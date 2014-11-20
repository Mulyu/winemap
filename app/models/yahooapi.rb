require 'net/http'
require 'uri'
require 'json'

class Yahooapi < ActiveRecord::Base

  def self.request(jan_code)
    webapi(
      'http://shopping.yahooapis.jp/ShoppingWebService',
      '/V1/json/itemSearch',
      {
        appid: 'dj0zaiZpPTNKd1RtRXFrY1lrdSZzPWNvbnN1bWVyc2VjcmV0Jng9YzM-',
        jan: jan_code
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
