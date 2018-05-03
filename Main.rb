require 'sinatra'
require 'twilio-ruby'
require 'sinatra/base'
require 'uri'
require './Worker.rb'
require 'stripe'

set :publishable_key, 'pk_test_Bt6PgAyfsT00OIRzjPVd3mQs'
set :secret_key, 'sk_test_jExBMJHRY8EdED1PU0pALhqI'
Stripe.api_key = settings.secret_key
get '/' do
	@chosenTime=params["exit-time"]
	if(@chosenTime==nil)
		@currentTime=getCurrentTime().to_s

	else
		@currentTime=@chosenTime.to_s

	end

	erb :mainPage
end
get '/getinfo' do
	
	erb :page2

end

get '/testing' do
	@please="Trying to fix"
	#OurWorker.perform_in(10,"testing")
	

	return @please
end

get '/stripe' do
  erb :index
end

post '/charge' do
	@chosenTime=params["exit-time"]

	if(@chosenTime==nil)
		@currentTime=getCurrentTime().to_s
	else
		@currentTime=@chosenTime.to_s
	end
	 # Amount in cents
  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Sinatra Charge',
    :currency    => 'usd',
    :customer    => customer.id
  )
 # delayTime()
  erb :charge
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
	@newnumber=params[:number]
	string= "+1#{@newnumber}"
	ffcaller(string)
end






