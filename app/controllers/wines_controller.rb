class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update, :destroy]
  before_action :set_winetypes, :set_winevarieties, :set_situations, only: [:new, :edit, :create, :update]

  UNKNOWN_COUNTRY_OR_LOCALREGION_ID = 1
  UNKNOWN_SVG_LAT_OR_LNG = 100.12345

  # GET /wines
  # GET /wines.json
  def index

    wines = Wine.includes(:winetype , :winevarieties , :user , :localregions , country: :worldregion).where(user_id: 1)

    #array mapping
    @array_wines = wines.map{ |wine|
      {
        wine_id: wine.id,
        winetype_id: wine.winetype_id,
        name: wine.name,
        country_name: wine.country.name,
        svg_latitude: wine.svg_latitude,
        svg_longitude: wine.svg_longitude,
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
        localregions: wine.localregions
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
        check_localregions(array_addresses)

        # 緯度経度情報ハッシュ
        hash_location = response['results'][0]['geometry']['location']

        @wine.svg_latitude = hash_location['lat']
        @wine.svg_longitude = hash_location['lng']

      else
        # レスポンスが無い、もしくはCountryが含まれていない場合は不明とする
        @wine.country_id = UNKNOWN_COUNTRY_OR_LOCALREGION_ID
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

    def check_localregions(array_addresses)
      # 国の次の区分から地域名を取得
      localregion_names = array_addresses.reverse_each.map { |address| address['long_name'] }.drop(1)

      @wine.localregions.clear

      localregion_names.each.with_index(1) do |localregion_name, layer|
        # localregionがすでにDBに存在するか
        localregion_db = Localregion.find_by(name: localregion_name)
        if localregion_db.present?
          # 存在する場合はそのデータとの関連を登録
          @wine.localregions.push(localregion_db)
        else
          # 存在しない場合はlocalregionsテーブルへ新しく追加して関連を登録
          @wine.localregions.build(name: localregion_name, ranking: 9_999_999, layer: layer, country_id: @wine.country_id)
        end
      end
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
