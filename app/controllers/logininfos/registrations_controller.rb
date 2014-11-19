class Logininfos::RegistrationsController < Devise::RegistrationsController
 
  def new
    
    @user=User.new
    super
  
  end
 
  def create
    @user = User.new(user_params)
    super
    
    if resource.id != nil
      @user.winelevel = @user.winenum = @user.follow = @user.follower = @user.ranking = 0
      @user.logininfo_id=resource.id
      @user.save
    end

    # send welcome mail
    LogininfoMailer.registration_confirmation(resource).deliver unless resource.invalid?
    
  end
  
  def user_params
      params.require(:user).permit(:name, :birth, :gender, :prefecture_id, :home_prefecture_id, :job, :married, :introduction)
  end
  
end
