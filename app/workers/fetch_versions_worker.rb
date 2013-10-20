class FetchVersionsWorker
  include Sidekiq::Worker

  def perform(gem_name)
    versions = Gems.versions(gem_name)

    versions.each do |version|
      number = version['number']
      FetchGemWorker.perform_async(gem_name, number)
    end
  end

end
