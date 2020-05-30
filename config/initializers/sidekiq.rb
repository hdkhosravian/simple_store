redis_config = Rails.application.config_for(:redis)
url = "redis://#{redis_config[:host]}:#{redis_config[:port]}/#{redis_config[:db]}"

Sidekiq.configure_server do |config|
  config.logger.level = Logger::WARN
  config.log_formatter = Sidekiq::Logger::Formatters::JSON.new
  config.redis = { url: url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: url }
end

Redis.current = Redis.new(url: url)
