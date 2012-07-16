class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
  end
  
  def send_instruction # ajax call here
    user = Smb.find_by_email(params[:reset_password_email])
    if user
      user.send_password_reset
      render json:ActiveSupport::JSON.encode({:ok => true})
    else
      render json:ActiveSupport::JSON.encode({:ok => false})
    end
  end

  def edit
    @smb = Smb.find_by_password_reset_token!(params[:id])
  end
  


  def update
    @smb = Smb.find_by_password_reset_token!(params[:id])
    if @smb.password_reset_sent_at < 2.hours.ago
      flash[:error] = "Password reset has expired. Please request again."
      redirect_to root_url
    elsif @smb.update_attributes(params[:smb])
      flash[:notice] = "Password has been reset."
      redirect_to root_url
    else
      render :edit
    end
  end


end
