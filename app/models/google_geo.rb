require 'net/http'
require 'uri'
require 'json'

class GoogleGeo < ActiveRecord::Base

  def self.request(address)
    uri = Addressable::URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false&language=ja")
    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

end
