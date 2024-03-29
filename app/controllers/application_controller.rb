class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  #before_filter :prepare_for_mobile
  
  helper_method :current_user
  helper_method :admin?

  private



  def current_user
    @current_user ||= Smb.find_by_auth_token!(cookies[:smb_auth_token]) if cookies[:smb_auth_token]
  end
  
  def admin?
    if current_user
      current_user.admin == true
    else
      false
    end
  end
  
   def mobile_device?
      if session[:mobile_param]
        session[:mobile_param] == "1"
      else
        request.user_agent =~ /Mobile|webOS/
      end
    end
    helper_method :mobile_device?

    def prepare_for_mobile
      session[:mobile_param] = params[:mobile] if params[:mobile]
      request.format = :mobile if mobile_device?
    end
end
