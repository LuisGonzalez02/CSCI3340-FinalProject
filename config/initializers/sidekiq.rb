require 'sidekiq'
require_relative './../../lib/workers/test_worker.rb'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { :size => 5 }
end
