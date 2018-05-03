require './Main.rb'

run Rack::URLMap.new('/' => App, '/sidekiq' => Sidekiq::Web)