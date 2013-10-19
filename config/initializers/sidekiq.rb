settings = { namespace: "memoirs_#{Rails.env}" }

Sidekiq.configure_server do |config|
  config.redis = settings
end

Sidekiq.configure_client do |config|
  config.redis = settings
end