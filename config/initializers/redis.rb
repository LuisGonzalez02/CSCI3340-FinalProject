require 'redis'

uri = URI.parse(ENV['REDIS_PROVIDER'])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
