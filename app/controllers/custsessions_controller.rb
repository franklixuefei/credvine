class CustsessionsController < ApplicationController
  def create
    session[:auth] = request.env["omniauth.auth"] #store some facebook info to a sessiony
    redirect_to "/#{Smb.find(session[:temp_smb_id]).username}" #, :notice => "Signed in!" #TODO maybe do not need notice
  end

  def destroy
    session[:auth] = nil
    redirect_to "/#{Smb.find(session[:temp_smb_id]).username}"#, :notice => "Signed out!"
    session[:temp_smb_id] = nil # optional
  end
  
end
