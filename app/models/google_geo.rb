require 'net/http'
require 'uri'
require 'json'

class GoogleGeo < ActiveRecord::Base

  def self.request(address)
    webapi(
      'http://maps.googleapis.com',
      '/maps/api/geocode/json',
      {
        address: address.gsub(/\s/, '%20'),
        sensor: 'false',
        language: 'ja'
      }
    )
  end

  def self.webapi(site, path, hash_params)
    params = hash_params.map { |key, value| "#{key}=#{value}" }.join('&')
    uri = Addressable::URI.parse("#{site}#{path}?#{params}")
    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

end
