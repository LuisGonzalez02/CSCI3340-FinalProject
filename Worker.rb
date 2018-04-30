require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'



class OurWorker
	include Sidekiq::Worker

	def perform(complexity)
		case complexity
		when "testing"
			delayTime()
		end
	end
end


