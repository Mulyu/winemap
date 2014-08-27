class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update, :destroy]

  # GET /wines
  # GET /wines.json
  def index
    @wines = Wine.all
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
      params.require(:wine).permit(:name, :country_or_region, :body, :sweetness, :sourness, :winetype_id, :year, :winevariety_id, :score, :price, :winery)
    end

    def normalize_wine_data
      ### ユーザーの入力ワインデータを正規化

      # Google Geocoding APIから正しい住所と緯度経度を取得
      response = GoogleGeo.request(params[:wine][:country_or_region])

      # country_or_regionの入力がない場合は飛ばす
      if response['status'] == 'OK'

        # 住所情報配列
        array_addresses = response['results'][0]['address_components']

        ### 国コードから一致するcountry_idを設定
        country_code = array_addresses[array_addresses.find_index { |address| address['types'][0] == 'country' }]['short_name'].downcase
        @wine.country_id = Country.where('svg_id = ?', country_code).first.id

        localregion_index = array_addresses.find_index { |address| address['types'][0] == 'administrative_area_level_1' }
        localregion_name = localregion_index ? array_addresses[localregion_index]['long_name'] : nil

        ### localregionが記述されている場合はすでにDBに含まれているか
        if localregion_index
          agreed_localregion = Localregion.find_by(name: localregion_name)
          if agreed_localregion
            # 含まれている場合はidをセット
            @wine.localregion_id = agreed_localregion.id
          else
            # 含まれていない場合はDBへ追加後idをセット
            new_localregion = Localregion.new(name: localregion_name, ranking: 9_999_999, country_id: @wine.country_id)
            new_localregion.save
            @wine.localregion_id = new_localregion.id
          end
        end

        ### 緯度経度情報からSVGデータの座標を計算
        # 緯度経度情報ハッシュ
        hash_location = response['results'][0]['geometry']['location']

      end

      # とりあえず決め打ち
      @wine.svg_x = 100.12345
      @wine.svg_y = 100.12345


      ### 画像を保存
      unless params[:wine][:photo].nil?
        photo = params[:wine][:photo]
        photo_path = "winephoto/#{Wine.maximum(:id)+1}#{File.extname(photo.original_filename)}"
        File.open("public/#{photo_path}", 'wb') { |f| f.write(photo.read) }
        @wine.photopath = photo_path
      end

      ### usersテーブルから取得
      # ログイン機能を実装するまでとりあえず決め打ち
      @wine.user_id = 1
      @wine.winelevel = 1.5

    end

end