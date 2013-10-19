class FetchGemWorker
  include Sidekiq::Worker

  LATENCY = 3.hours.ago

  def perform(gem_name)
    return if gem_up_to_date?(gem_name)

    sleep 10

    ruby_gem = RubyGem.create(name: gem_name)

    Version.create(ruby_gem: ruby_gem, number: "0.0.1", release_notes: "requested release...")
  end

  private

  def gem_up_to_date?(gem_name)
    RubyGem.where(name: gem_name).where("updated_at > ?", LATENCY).any?
  end
end
