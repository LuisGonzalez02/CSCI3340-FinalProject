require 'redis'

uri = URI.parse(ENV["redis://redistogo:c6335ef7dd50390873ab720ce80bab44@soldierfish.redistogo.com:11528/"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
