require 'sinatra'
require 'twilio-ruby'
require 'sinatra/base'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'



	Sidekiq.configure_client do |config|
		config.redis={url: ENV['REDIS_PROVIDER']}
	end
	Sidekiq.configure_server do |config|
		config.redis={URL: ENV['REDIS_PROVIDER']}
	end

class OurWorker
	include Sidekiq::Worker

	def perform(complexity)
		case complexity
		when "testing"
			delayTime()
		end
	end
end

get '/' do
	@chosenTime=params["exit-time"]
	if(@chosenTime==nil)
		@currentTime=getCurrentTime().to_s

	else
		@currentTime=@chosenTime.to_s

	end

	erb :mainPage
end

get '/testing' do
	@please="The past"
	OurWorker.perform_in(10,"testing")
	

	return @please
end



#function that returns the current time 
def getCurrentTime()
	return Time.now.strftime("%H:%M")
end

#function that does something after 10 seconds
def delayTime()
	account_sid = 'AC3040bfd66e0c15eeae03e6b7bd55443c'
	auth_token = 'a10018bf4cfb66aa234e84b45960c3f5'

	# set up a client to talk to the Twilio REST API
	@client = Twilio::REST::Client.new account_sid, auth_token

	def ffcaller(calledNumber)
	call = @client.calls.create(
	   to: calledNumber,
	   from: "+12019928984",
	   url: "https://handler.twilio.com/twiml/EHe5881b22b8f52a84a6b22a72c2882d39")
	puts call.to
	end

	newnumber=9563523539
	string= "+1#{newnumber}"
	ffcaller(string)
end






