class Logininfos::SessionsController < Devise::SessionsController
	respond_to :html,:json
	protect_from_forgery :except => [:create]
  def new
    super
  end
 
  def create
  	self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    if params[:mobile] then
      # モバイルから接続した場合は端末ごとに認証トークンを登録
    	resource[:mobile_token] = SecureRandom.hex(16)
     	resource.save
    	respond_with resource
    else
	    respond_with resource, location: after_sign_in_path_for(resource)
    end
  end
 
  def destroy
    super
  end

end