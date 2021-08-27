class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?




  protected


  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end



 def authenticate_user
   @current_user= User.find_by(id: session[:user_id])
   if @current_user == nil
     redirect_to("/login")
   end
 end

 

end
