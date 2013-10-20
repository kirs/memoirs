module ReleaseNotesImporter
  def self.import(gem_name)
    release_notes, file_name = ReleaseNotesFetcher.fetch(gem_name)

    file_extension = FileExtension.from_file_name(file_name)

    versions = ReleaseNotesParser.parse(release_notes, file_extension)

    create_needed_versions(versions, file_extension.to_s, gem_name)
  end

  private

  def self.create_needed_versions(versions, file_extension, gem_name)
    gem = RubyGem.first_or_create(name: gem_name)
    gem.versions.destroy_all

    versions.each do |version_number, release_notes|
      gem.versions.create!(number: version_number, release_notes: release_notes)
    end
  end
end
