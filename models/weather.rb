require 'mongoid'

class Weather
	include Mongoid::Document
	include Mongoid::Timestamps
	field :temp
	field :humidity
	field :dewpoint
	field :pressure
	field :light
	field :wind_speed
	field :wind_direction
	field :rainfall
	
end