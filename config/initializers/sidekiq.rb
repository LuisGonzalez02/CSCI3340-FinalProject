Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redistogo:c6335ef7dd50390873ab720ce80bab44@soldierfish.redistogo.com:11528/' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redistogo:c6335ef7dd50390873ab720ce80bab44@soldierfish.redistogo.com:11528/' }
end