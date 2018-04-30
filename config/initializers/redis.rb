require 'redis'

uri = URI.parse(ENV[""])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
