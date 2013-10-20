class FetchGemWorker
  include Sidekiq::Worker

  def perform(gem_name, number)
    ReleaseNotesImporter.import(gem_name, number)
  end

end
