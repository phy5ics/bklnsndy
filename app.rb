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
	
	port_str = "/dev/tty.RN42-B7F5-SPP"
  baud_rate = 9600
  data_bits = 8
  stop_bits = 1
  parity = SerialPort::NONE

  serial = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
  
  while true do
    # data = printf("%c", serial.getc)
    # puts data
    data = serial.readline
    
    puts data
    
    arr = data.split(',')
    
    # puts arr[1]
    # puts arr[2]
    # puts arr[3]
    # puts arr[4]
    # puts arr[5]
    # puts arr[6]
    # puts arr[7]
    # puts arr[8]
    # puts arr[9]
    # puts "-----"
    
    Weather.create(
      temp: arr[1],
    	humidity: arr[2],
    	dewpoint: arr[3],
    	pressure: arr[4],
    	light: arr[5],
    	wind_speed: arr[6],
    	wind_direction: arr[7],
    	rainfall: arr[8],
    )

    Pusher['weather'].trigger('weather_data', :message => arr)    
    
  end
  
end

module Bklnsndy
  class App < Sinatra::Base
   
    get '/' do
      haml :index
    end
  
  end
end
