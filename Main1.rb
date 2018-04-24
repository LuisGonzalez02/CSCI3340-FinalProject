require 'sinatra'

#this is the twilio library
require 'twilio-ruby'
#this are the credentioals required from my twilio account
account_sid = 'AC3040bfd66e0c15eeae03e6b7bd55443c'
auth_token = 'a10018bf4cfb66aa234e84b45960c3f5'
#this line is needed to declere the twilio client
@client = Twilio::REST::Client.new account_sid, auth_token
#the twilio  caller function
def ffcaller(calledNumber)
# here everything is preformated to work on twilio, we just need to modify the 
#number we want to call and the url, the from number is from twilio
#note: the twilio account is a trial account, if we want to call a number first
#      we need to verify that number on my twilio account
call = @client.calls.create(
   to: calledNumber,
   from: "+12019928984",
   url: "https://handler.twilio.com/twiml/EHe5881b22b8f52a84a6b22a72c2882d39")
puts call.to
end
#the link can only be modify on my twilio account, for now is just a basic message
#for tests
#we need a number from the params, for testing purposes i was using my number
#add that number to a string with a +1 at the front to select the country
#and call the function Eample:
#	newnumber=956xxxxxxx
#	string= "+1#{newnumber}"
#	ffcaller(string)









post '/' do
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