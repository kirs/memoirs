module ReleaseNotesImporter
  def self.import(gem_name, number)
    release_notes, file_name = ReleaseNotesFetcher.fetch(gem_name, number)
    file_extension = FileExtension.from_file_name(file_name)
    versions = ReleaseNotesParser.parse(release_notes, file_extension)
    notes = versions[number]

    create_ruby_gem(gem_name, number, notes)
  end

  private

  def self.create_ruby_gem(gem_name, number, release_notes)
    ruby_gem = RubyGem.find_or_create_by!(name: gem_name)
    ruby_gem.versions.create!(number: number, release_notes: release_notes)
  end
end
