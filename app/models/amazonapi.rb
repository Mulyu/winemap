require 'openssl'
require 'base64'
require 'net/http'
require 'uri'
require 'json'
require 'cgi'
require 'digest/sha2'
require 'time'

class Amazonapi < ActiveRecord::Base

  def self.request(jan_code)

    aws_host   = 'webservices.amazon.co.jp'

    if Rails.env == 'development'
      keys = YAML::load(File.open("#{Rails.root.to_s}/config/apikey.yml"))
      access_key = keys['amazon']['access_key']
      secret_key = keys['amazon']['secret_key']
    elsif Rails.env == 'production'
      access_key = Rails.application.secrets.amazon_access_key
      secret_key = Rails.application.secrets.amazon_secret_key
    end

    req = ["Service=AWSECommerceService", "AWSAccessKeyId=#{access_key}", "Version=2009-06-01"]

    req << "Operation=ItemSearch"
    req << "Keywords=#{jan_code}"
    req << "Timestamp=#{CGI.escape(Time.now.getutc.iso8601)}"
    req << "AssociateTag=suiyujin-22"
    req << "Condition=All"
    req << "Merchant=All"
    req << "SearchIndex=Grocery"

    req.sort!

    message = ['GET',aws_host,'/onca/xml',req.join('&')].join("\n")

    sign = make_signature(secret_key, message)
    req << "Signature=#{CGI.escape(sign)}"

    webapi(
      "http://#{aws_host}",
      '/onca/xml',
      req.join('&')
    )
  end

  def self.webapi(site, path, params)
    uri = Addressable::URI.parse("#{site}#{path}?#{params}")
    xml = Net::HTTP.get(uri)
    json = Hash.from_xml(xml).to_json
    JSON.parse(json)
  end

  def self.make_signature(secret_key, message)
    hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, secret_key, message)
    Base64.encode64(hash).split.join
  end

end