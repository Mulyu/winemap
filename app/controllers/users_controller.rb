class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :follow, :remove]
  before_action :set_prefectureregions, only: [:new, :edit, :create, :update]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
  end
  
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    check_current_user
  end
  
  # GET /mypage
  def mypage
    @followed = @current_user.followed
    @following = @current_user.following
    @list_size = [@followed.size,@following.size].max
  end

  # POST /users/1/follow
  def follow
    @current_user.follow!(@user)
    redirect_to @user
  end

  # POST /remove
  def remove
    @current_user.remove!(@user)
    redirect_to @user
  end
  
  # POST /users
  # POST /users.json
  def create

    check_current_user

    @user = User.new(user_params)

    @user.winelevel = @user.winenum = @user.follow = @user.follower = @user.ranking = 0

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    check_current_user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    
    check_current_user

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_prefectureregions
      @prefectureregions = Prefectureregion.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :birth, :gender, :prefecture_id, :home_prefecture_id, :job, :married, :introduction)
    end

    def check_current_user
      if @user != @current_user
        redirect_to @user, notice: 'あなたは指定されたユーザではありません'
      end
    end
end
