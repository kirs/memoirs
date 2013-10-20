class AsyncGemFetcher

  def initialize(gem_name)
    @gem_name = gem_name
    @job_klass = FetchVersionsWorker
  end

  def fetch
    if already_enqueued?
      Rails.logger.info "'#{@gem_name}' task required, but it's already_enqueued"
      return
    end

    @job_klass.perform_async(@gem_name)
  end

  private

  def already_enqueued?
    Sidekiq::Queue.new.any? { |job| job.klass == @job_klass.name && job.args == [@gem_name] }
  end
end
