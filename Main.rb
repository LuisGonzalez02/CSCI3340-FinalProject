require 'twilio-ruby'
require 'sinatra/base'
require 'uri'
require 'stripe'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'

require_relative 'lib/workers/test_worker.rb'



class App < Sinatra::Base
	set :publishable_key, 'pk_test_Bt6PgAyfsT00OIRzjPVd3mQs'
	set :secret_key, 'sk_test_jExBMJHRY8EdED1PU0pALhqI'
	Stripe.api_key = settings.secret_key


	get '/' do


	erb :mainPage
	end
	get '/getinfo' do
		erb :page2

	end



	post '/charge' do
		stats = Sidekiq::Stats.new
		workers = Sidekiq::Workers.new
		
		# @inProgress=workers.size
		# @toProcessed=stats.processed
		# @toEnqueued=stats.enqueued

		@chosenTime=params["exit-time"]

		if(@chosenTime==nil)
			@currentTime=getCurrentTime().to_s
		else
			@currentTime=@chosenTime.to_s
		end
		 # Amount in cents
	  @amount = 100

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
	  	usrTime=params["exit-time"]
	    hour=Time.now.strftime("%H").to_i
		minute=Time.now.strftime("%M").to_i
		usrHour=DateTime.parse(usrTime).strftime("%H").to_i
		usrMin=DateTime.parse(usrTime).strftime("%M").to_i
		waitTime=((usrHour-hour)*60)+(usrMin-minute)
		#put an if check for if negative number, if yes,ask user for new time

		#puts "#{hour} #{minute} #{usrHour} #{usrMin} #{waitTime}"

	  newnumber=params[:number]
	  TestWorker.perform_in(waitTime.minutes,newnumber)
	  erb :charge
	end


	#function that returns the current time 
	def getCurrentTime()
		return Time.now.strftime("%H:%M")
	end



end









