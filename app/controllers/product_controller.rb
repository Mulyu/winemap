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
      # Amazonで検索
      res_amazon = Amazonapi.request(jan_code)

      count_req = 0
      no_res_amazon = false

      # RequestThrottledエラーの場合に再リクエスト
      while res_amazon.has_key?('ItemSearchErrorResponse') && res_amazon['ItemSearchErrorResponse']['Error']['Code'] == 'RequestThrottled'
        sleep 1
        res_amazon = Amazonapi.request(jan_code)
        count_req += 1
        if count_req >= 5
          no_res_amazon = true
          break
        end
      end

      # Amazonで結果が無かった場合はYahooで検索
      if res_amazon['ItemSearchResponse']['Items']['TotalResults'].to_i > 0 && !no_res_amazon
        items = res_amazon['ItemSearchResponse']['Items']
        item = items['Item'].instance_of?(Array) ? items['Item'][0] : items['Item']
        return item['ItemAttributes']['Title']
      else
        res_yahoo = Yahooapi.request(jan_code)
        if res_yahoo['ResultSet']['totalResultsReturned'].to_i > 0
          return res_yahoo['ResultSet']['0']['Result']['0']['Name']
        end
      end

      # どちらも結果が無かった場合
      return 0
    end
end
