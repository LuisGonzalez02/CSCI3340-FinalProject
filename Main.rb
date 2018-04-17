require 'sinatra'

get '/' do
hour=params["Hour"]
minute=params["Minute"]
@time=nil
if(hour!=nil&&minute!=nil&&!hour.empty?&&!minute.empty?)
@time=hour.to_s+":"+minute.to_s
end


erb :mainPage
end