class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update, :destroy]

  UNKNOWN_COUNTRY_OR_LOCALREGION_ID = 1
  UNKNOWN_SVG_LAT_OR_LNG = 100.12345

  # GET /wines
  # GET /wines.json
  def index

    wines = Wine.includes(:winetype , :winevarieties ,:user , :localregion , country: :worldregion ).where(user_id: 1)

    #array mapping
    @array_wines = wines.map{ |wine|

      { wine_id: wine.id, winetype_id: wine.winetype_id ,name: wine.name , country_name: wine.country.name , svg_latitude: wine.svg_latitude ,svg_longitude: wine.svg_longitude ,body: wine.body , sweetness: wine.sweetness , winetype_name: wine.winetype.name , year: wine.year , winevarieties: wine.winevarieties , score: wine.score , price: wine.price , winery: wine.winery , user: wine.user.name , winelevel: wine.winelevel , worldregion_id: wine.country.worldregion_id }

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

    # Never trust parameters from the scary internet, only allow the white list through.
    def wine_params
      params.require(:wine).permit(:name, :input_region, :body, :sweetness, :sourness, :winetype_id, :year, {:winevariety_ids => []}, :score, :price, {:situation_ids => []}, :winery)
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

        @wine.svg_latitude = hash_location['lat']
        @wine.svg_longitude = hash_location['lng']

      else
        # レスポンスが無い、もしくはCountryが含まれていない場合は不明とする
        @wine.country_id = @wine.localregion_id = UNKNOWN_COUNTRY_OR_LOCALREGION_ID
        @wine.svg_latitude = @wine.svg_longitude = UNKNOWN_SVG_LAT_OR_LNG
      end

      ### 画像を保存してphotopathをセット
      @wine.photopath = upload_photo if params[:wine][:photo].present?

      ### usersテーブルから取得
      # ログイン機能を実装するまでとりあえず決め打ち
      @wine.user_id = 1
      @wine.winelevel = 1.5

    end

    def find_country(array_addresses)
      # 国コードを使って一致するcountry_idを返す
      country_index = array_addresses.find_index { |address| address['types'][0] == 'country' }
      country_code = array_addresses[country_index]['short_name'].downcase
      Country.where('svg_id = ?', country_code).first.id
    end

    def select_localregion_id(array_addresses)
      localregion_index = array_addresses.find_index { |address| address['types'][0] == 'administrative_area_level_1' }
      localregion_name = localregion_index ? array_addresses[localregion_index]['long_name'] : nil

      unless localregion_name.present?
        # localregionが無い場合は不明とする
        return UNKNOWN_COUNTRY_OR_LOCALREGION_ID
      end

      # localregionがすでにDBに存在するか
      localregion_db = Localregion.find_by(name: localregion_name)
      unless localregion_db.present?
        # 存在しない場合はDBへ新しく追加してidを返す
        new_localregion = Localregion.new(name: localregion_name, ranking: 9_999_999, country_id: @wine.country_id)
        new_localregion.save
        return new_localregion.id
      end

      # 存在する場合は一致したidを返す
      localregion_db.id
    end

    def upload_photo
      # 画像を保存
      photo = params[:wine][:photo]
      photo_name = @wine.id ? @wine.id : (Wine.maximum(:id).next)
      photo_path = "/winephoto/#{photo_name}#{File.extname(photo.original_filename).downcase}"
      File.open("public#{photo_path}", 'wb') { |f| f.write(photo.read) }
      photo_path
    end

end
