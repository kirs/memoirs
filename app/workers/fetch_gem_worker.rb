class FetchGemWorker
  include Sidekiq::Worker

  LATENCY = 3.hours

  def perform(gem_name)
    return if gem_up_to_date?(gem_name)
    ReleaseNotesImporter.import(gem_name)
  end

  private

  def gem_up_to_date?(gem_name)
    RubyGem.where(name: gem_name).where("updated_at > ?", LATENCY.ago).any?
  end

end
