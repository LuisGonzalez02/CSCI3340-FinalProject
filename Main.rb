require 'twilio-ruby'
require 'sinatra/base'
require 'uri'
require 'stripe'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'

require_relative 'lib/workers/test_worker.rb'



class App < Sinatra::Base

	get '/' do
		stats = Sidekiq::Stats.new
		workers = Sidekiq::Workers.new
		"
		<p>Processed: #{stats.processed}</p>
		<p>In Progress: #{workers.size}</p>
		<p>Enqueued: #{stats.enqueued}</p>
		<p><a href='/'>Refresh</a></p>
		<p><a href='/add_job'>Add Job</a></p>
		<p><a href='/sidekiq'>Dashboard</a></p>
		"
	end

	get '/add_job' do
		"
		<p>Added Job: #{::TestWorker.perform_async(20)}</p>
		<p><a href='/'>Back</a></p>
		"
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
		stats = Sidekiq::Stats.new
		workers = Sidekiq::Workers.new
		
		@inProgress=workers.size
		@toProcessed=stats.processed
		@toEnqueued=stats.enqueued

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
	 TestWorker.perform_async(20)
	  erb :charge
	end


	#function that returns the current time 
	def getCurrentTime()
		return Time.now.strftime("%H:%M")
	end






end









