require	'net/http'
require 'timeout'
require 'uri'
require 'json'
require 'open-uri'
require 'rexml/document'

class HomeController < ApplicationController
	
	def home
		city_number = '400040'
		path = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=' + city_number
		uri = URI.parse(path)
		get_req = Net::HTTP::Get.new(path)
		
		res = Net::HTTP.start(uri.host, uri.port) {|http|
        		http.request(get_req)        		
        	}	
        	parsed_res = JSON.parse(res.body)

        	@aa = parsed_res['forecasts'][0]['temperature']['min']['celsius']
		
	end	
	
	def map
	end

end
