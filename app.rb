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
	
	Pusher.app_id = ENV['PUSHER_ID']
	Pusher.key = ENV['PUSHER_KEY']
	Pusher.secret = ENV['PUSHER_SECRET']
  
end

module Bklnsndy
  class App < Sinatra::Base
   
    get '/' do
      @pusher_key = '7837ec4d76bcffdb62c5'
      haml :index
    end
    
    get '/global.css' do
      content_type 'text/css'
      sass :global
    end
  
  end
end
