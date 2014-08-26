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

    ### 入力データを正規化
    # Google Geocoding APIから正しい住所と緯度経度を取得
    response = GoogleGeo.request(params[:country_or_region])

    ## ステータスコードによって(OK以外は)再入力させる？

    # 住所情報配列
    array_addresses = response['results'][0]['address_components']
    # 緯度経度情報ハッシュ
    hash_location = response['results'][0]['geometry']['location']

    ### 住所情報から一致するcountry_idを検索

    ### localregionが記述されている場合はすでにDBに含まれているか
    # 含まれている場合はlocalregion_idをセット

    # 含まれていない場合は追加

    ### 緯度経度情報からSVGデータの座標を計算


    # とりあえず決め打ち
    @wine.country_id = 1
    @wine.localregion_id = 1
    @wine.svg_x = 100.12345
    @wine.svg_y = 100.12345

    ### usersテーブルから取得
    # ログイン機能を実装するまでとりあえず決め打ち
    @wine.user_id = 1
    @wine.winelevel = 1.5

    # raise # debug

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
      params.require(:wine).permit(:name, :country_id, :localregions_id, :svg_x, :svg_y, :body, :sweetness, :sourness, :winetype_id, :year, :winevariety_id, :photopath, :score, :price, :winery, :user_id, :winelevel)
    end
end
