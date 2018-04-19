require 'sinatra'

get '/' do
@chosenTime=params["exit-time"]
if(@chosenTime==nil)
	@currentTime=getCurrentTime().to_s

else
	@currentTime=@chosenTime.to_s
end


erb :mainPage
end

def getCurrentTime()
	return Time.now.strftime("%H:%M")
end
