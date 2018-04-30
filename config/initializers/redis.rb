require 'redis'

redis_uri = URI.parse(ENV["REDIS_PROVIDER"])
REDIS = Redis.new(:uri: redis_uri)
