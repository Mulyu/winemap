class Logininfos::SessionsController < Devise::SessionsController
	respond_to :html,:json
	protect_from_forgery :except => [:create,:destroy]
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
    	resource[:mobile_token] = SecureRandom.hex(8)
     	resource.save
     	respond_to do |format|
     		format.json{render :json => resource}
     		format.html{after_sign_in_path_for(resource)}
     	end
    else
    	respond_with resource, location: after_sign_in_path_for(resource)
    end
  end
 
  def destroy
  	signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    if params[:mobile] then
    	resource[:mobile_token] = nil
    	resource.save
    end
    respond_to_on_destroy
  end

end