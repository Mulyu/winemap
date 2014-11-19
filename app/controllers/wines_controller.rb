# encoding: utf-8

class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update, :destroy]
  before_action :set_winetypes, :set_winevarieties, :set_situations, only: [:new, :edit, :create, :update]
  before_action :set_current_user
  UNKNOWN_COUNTRY_OR_LOCALREGION_ID = 1
  UNKNOWN_LAT_OR_LNG = 100.12345

  # GET /wines
  # GET /wines.json
  def index

    wines = Wine.includes(:winetype , :winevarieties , :user , :localregion , country: :worldregion).all

    #array mapping
    @array_wines = wines.map{ |wine|
      regions = wine.localregion.name.delete('不明').split(',')
      regions.unshift(wine.country.worldregion.name, wine.country.name)
      {
        wine_id: wine.id,
        winetype_id: wine.winetype_id,
        name: wine.name,
        country_name: wine.country.name,
        latitude: wine.latitude.to_f,
        longitude: wine.longitude.to_f,
        body: wine.body,
        sweetness: wine.sweetness,
        winetype_name: wine.winetype.name,
        year: wine.year,
        winevarieties: wine.winevarieties,
        score: wine.score,
        price: wine.price,
        winery: wine.winery,
        user: wine.user.name,
        winelevel: wine.winelevel,
        worldregion_id: wine.country.worldregion_id,
        regions: regions
      }
    }

  end

  # GET /wines/1
  # GET /wines/1.json
  def show
  end

  # GET /wines/new
  def new
    @wine = Wine.new
  end

  # GET /wines/1/edit
  def edit
    check_current_user
  end

  # POST /wines
  # POST /wines.json
  def create

    @wine = Wine.new(wine_params)
    
    normalize_wine_data

    respond_to do |format|
      if @wine.save
        format.html { redirect_to @wine, notice: 'Wine was successfully created.' }
        format.json { render :show, status: :created, location: @wine }
      else
        format.html { render :new }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wines/1
  # PATCH/PUT /wines/1.json
  def update

    check_current_user

    normalize_wine_data

    respond_to do |format|
      if @wine.update(wine_params)
        format.html { redirect_to @wine, notice: 'Wine was successfully updated.' }
        format.json { render :show, status: :ok, location: @wine }
      else
        format.html { render :edit }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wines/1
  # DELETE /wines/1.json
  def destroy
    
    check_current_user

    @wine.destroy
    respond_to do |format|
      format.html { redirect_to wines_url, notice: 'Wine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wine
      @wine = Wine.find(params[:id])
    end

    def set_winetypes
      @winetypes = Winetype.all
    end

    def set_winevarieties
      @winevarieties = Winevariety.all
    end

    def set_situations
      @situations = Situation.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wine_params
      params.require(:wine).permit(:name, :input_region, :body, :sweetness, :sourness, :winetype_id, :year, {:winevariety_ids => []}, :score, :price, {:situation_ids => []}, :winery, :photo)
    end

    def normalize_wine_data
      ### ユーザーの入力ワインデータを正規化

      # Google Geocoding APIから正しい住所と緯度経度を取得
      response = GoogleGeo.request(params[:wine][:input_region])

      ### 住所情報から必要な情報をセット
      if response['status'] == 'OK' && response['results'][0]['address_components'].any? { |address| address['types'][0] == 'country' }
        # 住所のレスポンスにCountryが含まれている場合

        # 住所情報配列
        array_addresses = response['results'][0]['address_components']

        @wine.country_id = find_country(array_addresses)
        @wine.localregion_id = select_localregion_id(array_addresses)

        # 緯度経度情報ハッシュ
        hash_location = response['results'][0]['geometry']['location']

        @wine.latitude = hash_location['lat']
        @wine.longitude = hash_location['lng']

        # 重複処理
        if Localregion.find(@wine.localregion).present?
          duplicated_num = Wine.where(localregion_id: @wine.localregion_id).size
          @wine.latitude -= 1.0e-1 * (duplicated_num / 5)
          @wine.longitude += 1.0e-1 * (duplicated_num % 5)
        end
      else
        # レスポンスが無い、もしくはCountryが含まれていない場合は不明とする
        @wine.country_id = @wine.localregion_id = UNKNOWN_COUNTRY_OR_LOCALREGION_ID
        @wine.latitude = @wine.longitude = UNKNOWN_LAT_OR_LNG
      end

      ### usersテーブルから取得
      ### 未ログイン時はid=1,winelevel=0に設定
      if current_logininfo == nil
        @wine.user_id = 1
        @wine.winelevel = 0.0
      else
        @wine.user_id = current_logininfo.user.id
        @wine.winelevel = current_logininfo.user.winelevel
      end
    end

    def find_country(array_addresses)
      # 国コードを使って一致するcountry_idを返す
      country_index = array_addresses.find_index { |address| address['types'][0] == 'country' }
      country_code = array_addresses[country_index]['short_name'].downcase
      Country.where('svg_id = ?', country_code).first.id
    end

    def select_localregion_id(array_addresses)
      # 国の次の区分から地域名を取得
      localregion_names = array_addresses.reverse.drop_while { |address| address['types'][0] != 'country' }.drop(1).map { |region| region['long_name'] }.join(',')

      unless localregion_names.present?
        # localregionが無い場合は不明とする
        return UNKNOWN_COUNTRY_OR_LOCALREGION_ID
      end

      # localregionがすでにDBに存在するか
      localregion_db = Localregion.find_by(name: localregion_names)
      unless localregion_db.present?
        # 存在しない場合はDBへ新しく追加してidを返す
        new_localregion = Localregion.new(name: localregion_names, ranking: 9_999_999, country_id: @wine.country_id)
        new_localregion.save
        return new_localregion.id
      end

      # 存在する場合は一致したidを返す
      localregion_db.id
    end

    def set_current_user
      if logininfo_signed_in?
        @current_user = current_logininfo.user
      end
    end
    # 未登録ユーザーが登録したワインは誰でも編集可能
    def check_current_user
      if @wine.user != @current_user && @wine.user.id != 1
        redirect_to @wine, notice: 'あなたはワインを登録したユーザーではありません'
      end 
    end
end
