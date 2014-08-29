class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update, :destroy]

  # GET /wines
  # GET /wines.json
  def index

    wines = Wine.includes(:winetype , :winevarieties ,:user , :localregion , country: :worldregion ).take(100)

    #array mapping
    @array_wines = wines.map{ |wine|

      { winetype_id: wine.winetype_id ,name: wine.name , country_name: wine.country.name , svg_latitude: wine.svg_latitude ,svg_longitude: wine.svg_longitude ,body: wine.body , sweetness: wine.sweetness , winetype_name: wine.winetype.name , year: wine.year , winevarieties: wine.winevarieties , score: wine.score , price: wine.price , winery: wine.winery , user: wine.user.name , winelevel: wine.winelevel , worldregion_id: wine.country.worldregion_id }

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

      ### country_id, localregion_idをセット
      if response['status'] == 'OK'
        # 住所のレスポンスがある場合は取得する

        # 住所情報配列
        array_addresses = response['results'][0]['address_components']

        # 国コードから一致するcountry_idを設定
        country_code = array_addresses[array_addresses.find_index { |address| address['types'][0] == 'country' }]['short_name'].downcase
        @wine.country_id = Country.where('svg_id = ?', country_code).first.id

        localregion_index = array_addresses.find_index { |address| address['types'][0] == 'administrative_area_level_1' }
        localregion_name = localregion_index ? array_addresses[localregion_index]['long_name'] : nil

        # localregionがDBの情報と一致するか
        if localregion_index
          agreed_localregion = Localregion.find_by(name: localregion_name)
          if agreed_localregion
            # 一致する場合はそのidをセット
            @wine.localregion_id = agreed_localregion.id
          else
            # 一致しない場合はDBへ追加後idをセット
            new_localregion = Localregion.new(name: localregion_name, ranking: 9_999_999, country_id: @wine.country_id)
            new_localregion.save
            @wine.localregion_id = new_localregion.id
          end
        end

        ### 緯度経度情報からSVGデータの座標を計算
        # 緯度経度情報ハッシュ
        hash_location = response['results'][0]['geometry']['location']
        @wine.svg_latitude = hash_location['lat']
        @wine.svg_longitude = hash_location['lng']

      else
        # レスポンスが無い場合は不明とする
        @wine.country_id = 1
        @wine.localregion_id = 1
        @wine.svg_latitude = 100.12345
        @wine.svg_longitude = 100.12345
      end

      ### 画像を保存してphotopathをセット
      unless params[:wine][:photo].nil?
        photo = params[:wine][:photo]
        photo_name = @wine.id ? @wine.id : (Wine.maximum(:id) + 1)
        photo_path = "/winephoto/#{photo_name}#{File.extname(photo.original_filename).downcase}"
        File.open("public#{photo_path}", 'wb') { |f| f.write(photo.read) }
        @wine.photopath = photo_path
      end

      ### usersテーブルから取得
      # ログイン機能を実装するまでとりあえず決め打ち
      @wine.user_id = 1
      @wine.winelevel = 1.5

    end

end
