module ReleaseNotesImporter
  def self.import(gem_name)
    release_notes, file_name = ReleaseNotesFetcher.fetch(gem_name)

    file_extension = FileExtension.from_file_name(file_name)

    versions = ReleaseNotesParser.parse(release_notes, file_extension)

    create_needed_versions(versions, file_extension.to_s, gem_name)
  end

  private

  def self.create_needed_versions(versions, file_extension, gem_name)
    ruby_gem = RubyGem.find_or_create_by!(name: gem_name)
    ruby_gem.versions.destroy_all

    versions.each do |version_number, release_notes|
      ruby_gem.versions.create!(number: version_number, release_notes: release_notes)
    end
  end
end
