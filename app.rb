require 'rubygems'
require 'sinatra'
require 'sinatra/flash'
require "sinatra/reloader" if development?
require 'haml'
require 'sass'
require 'mongoid'

require 'serialport'
require 'pusher'
require './models/weather'

set :environment, ENV['RACK_ENV']

configure do
	Mongoid.configure do |config|
		Mongoid.load!('config/mongoid.yml')
		# Mongoid.logger = nil
	end
	
	Pusher.app_id = '8269'
	Pusher.key = '7837ec4d76bcffdb62c5'
	Pusher.secret = 'db0d31f1c373b7bc25aa'
  
end

module Bklnsndy
  class App < Sinatra::Base
   
    get '/' do
      haml :index
    end
    
    get '/global.css' do
      content_type 'text/css'
      sass :global
    end
  
  end
end
