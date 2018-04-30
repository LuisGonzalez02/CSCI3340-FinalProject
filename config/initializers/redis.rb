require 'redis'

redis_uri = URI.parse(ENV["REDIS_PROVIDER"])
REDIS = Redis.new(:uri: "i dont know maybe")
