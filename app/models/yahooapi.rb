require 'net/http'
require 'uri'
require 'json'

class Yahooapi < ActiveRecord::Base

  def self.request(jan_code)

    keys = YAML::load(File.open("#{Rails.root.to_s}/config/apikey.yml"))
    app_id = keys['yahoo']['app_id']

    webapi(
      'http://shopping.yahooapis.jp/ShoppingWebService',
      '/V1/json/itemSearch',
      {
        appid: app_id,
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
