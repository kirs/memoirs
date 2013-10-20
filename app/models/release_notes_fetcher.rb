require 'rubygems/package'

module ReleaseNotesFetcher
  RELEASE_NOTES_REGEXP = /^changelog|^changes|^history/i

  def self.fetch(gem_name, number)
    raw_gem = fetch_raw_gem(gem_name, number)
    gem_data, _ = untar(raw_gem, /^data\.tar/)
    release_notes, file_name = untar(gem_data, RELEASE_NOTES_REGEXP)

    [release_notes, file_name]
  end

  private

  def self.fetch_raw_gem(gem_name, number)
    uri = URI.parse("http://rubygems.org/downloads/#{gem_name}-#{number}.gem")
    fetcher = Gem::RemoteFetcher.new

    fetcher.fetch_http(uri)
  end

  def self.untar(tar_string, file_name_matcher)
    extracted_file, file_name = nil

    Gem::Package::TarReader.new(StringIO.new(tar_string)).each_entry do |entry|
      if entry.full_name =~ file_name_matcher
        extracted_file = extract_entry(entry)
        file_name = entry.full_name
      end
    end

    [extracted_file, file_name]
  end

  def self.extract_entry(entry)
    return Gem.gunzip(entry.read) if entry.full_name =~ /\.gz$/
    entry.read
  end
end
