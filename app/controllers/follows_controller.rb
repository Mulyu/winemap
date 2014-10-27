class FollowsController < ApplicationController
  before_action :logininfo_signed_in?
  before_action :set_current_user, only: [:create,:destroy]
  def create
    @user = User.find(params[:id])
    current_logininfo.user.follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = User.find(params[:id])
    current_logininfo.user.remove!(@user)
    redirect_to @user
  end

  private
    def set_current_user
      @current_user = current_logininfo.user
    end

end
