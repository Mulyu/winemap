class LoginsController < ApplicationController
  def show
    render "new"
  end

  def create
    user = User.find_by_name params[:name]
    if user && user.authenticate(params[:pass])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now.alert = "please enter once more"
      render "new"
    end
  end
  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to login_path
  end
end
