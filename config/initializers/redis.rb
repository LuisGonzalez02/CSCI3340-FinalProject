theUrl=ENV["REDISTOGO_URL"].to_s
encoded_url=URI.encode(theUrl)
uri = URI.parse(encoded_url)
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
