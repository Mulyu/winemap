class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update, :destroy]

  # GET /wines
  # GET /wines.json
  def index

    wines = Wine.includes(:winetype , :winevariety ,:user , :localregion , country: :worldregion ).take(100)
    
    #array mapping
    @array_wines = wines.map{ |wine|

      { winetype_id: wine.winetype_id ,name: wine.name , country_name: wine.country.name , svg_x: wine.svg_x ,svg_y: wine.svg_y ,body: wine.body , sweetness: wine.sweetness , winetype_name: wine.winetype.name , year: wine.year , winevariety_name: wine.winevariety.name , score: wine.score , price: wine.price , winery: wine.winery , user: wine.user.name , winelevel: wine.winelevel , worldregion_name: wine.country.worldregion.name ,worldregion_center_x: wine.country.worldregion.center_x , worldregion_center_y: wine.country.worldregion.center_y}  
    
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
