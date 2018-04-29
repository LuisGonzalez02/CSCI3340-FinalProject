require 'sinatra'
require 'chrono'
require 'twilio-ruby'



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
	#thread exits when the block exits
	thr=Thread.new{
		delayTime()
	}
	Thread.join
	#used at end of  program to wait for all threads to finish before ending not necessary in this one
	#thr.join
	return @please
end



#function that returns the current time 
def getCurrentTime()
	return Time.now.strftime("%H:%M")
end

#function that does something after 10 seconds
def delayTime()
	trigger = Chrono::Trigger.new("59 18 29 4 0") { Time.now }
	trigger.once 
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






