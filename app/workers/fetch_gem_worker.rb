class FetchGemWorker
  include Sidekiq::Worker

  def perform(gem_name)
    sleep 10

    ruby_gem = RubyGem.create(name: gem_name)

    Version.create(ruby_gem: ruby_gem, number: "0.0.1", release_notes: "requested release...")
  end
end