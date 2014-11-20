class ProductController < ApplicationController
  def index
    jan_code = params[:jan]

    country_name = search_country(jan_code)
    product_name = search_product_name(jan_code)

    ret_json = {
      jan: jan_code,
      result: {
        country_name: country_name,
        product_name: product_name
      }
    }

    render json: ret_json
  end
  private
    def search_country(jan_code)
      country_code = jan_code.slice(0, 3).to_i

      # とりあえず日本だけ
      if (country_code >= 450 && country_code <= 459) || (country_code >= 490 && country_code <= 499)
        return '日本'
      else
        return 0
      end
    end

    def search_product_name(jan_code)
      res_amazon = Amazonapi.request(jan_code)

      if res_amazon.has_key?('ItemSearchErrorResponse') && res_amazon['ItemSearchErrorResponse']['Error']['Code'] == 'RequestThrottled'
        sleep 1
        res_amazon = Amazonapi.request(jan_code)
      end

      items = res_amazon['ItemSearchResponse']['Items']

      if items['TotalResults'].to_i > 0
        item = items['Item'].instance_of?(Array) ? items['Item'][0] : items['Item']
        return item['ItemAttributes']['Title']
      else
        res_yahoo = Yahooapi.request(jan_code)
        if res_yahoo['ResultSet']['totalResultsReturned'].to_i > 0
          return res_yahoo['ResultSet']['0']['Result']['0']['Name']
        end
      end

      return 0
    end
end
