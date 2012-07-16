class SessionsController < ApplicationController
  def new
  end


  def create
    user = Smb.authenticate(params[:email], params[:password])
    if user
      if params[:remember_me]
        cookies.permanent[:smb_auth_token] = user.auth_token
      else
        cookies[:smb_auth_token] = user.auth_token
      end
      flash[:notice] = "Logged in!"
      respond_to do |format|
        if user.first_time
          if user.activated
            if user.profile_completed
              if user.campaign_created
                if user.campaign_confirmed
                  if user.campaign_launched
                    format.html {redirect_to dashboard_smb_path(user)}
                    format.json {render json: ActiveSupport::JSON.encode({:url => dashboard_smb_path(user) })}
                  else
                    campaign = user.campaigns.find(:last, :conditions => ['temp = ?', false])
                    format.html {redirect_to campaign_launched_smb_campaign_path(user, campaign)}
                    format.json {render json: ActiveSupport::JSON.encode({:url => campaign_launched_smb_campaign_path(user, campaign) })} 
                  end
                else # !user.campaign_confirmed
                  format.html {redirect_to closer_last_smb_path(user)}
                  format.json {render json: ActiveSupport::JSON.encode({:url => closer_last_smb_path(user) })}
                end
              else #!user.campaign_created
                format.html {redirect_to closer_smb_path(user)}
                format.json {render json: ActiveSupport::JSON.encode({:url => closer_smb_path(user) })}
              end
            else #!user.profile_completed
              # after out of beta, change back to following two.
              #format.html {redirect_to edit_smb_path(user)}
              #format.json {render json: ActiveSupport::JSON.encode({:url => edit_smb_path(user) })}
              format.html {redirect_to navigation_smb_path(user)}
              format.json {render json: ActiveSupport::JSON.encode({:url => navigation_smb_path(user) })}
            end
          else #!user.activated
            format.html {redirect_to navigation_smb_path(user)}
            format.json {render json: ActiveSupport::JSON.encode({:url => navigation_smb_path(user) })}
          end
        else #!user.first_time
          format.html {redirect_to dashboard_smb_path(user)}
          format.json {render json: ActiveSupport::JSON.encode({:url => dashboard_smb_path(user) })}
        end
      end
    else
      flash[:error] = "Invalid email or password"
      render json: ActiveSupport::JSON.encode({:ok => false })
    end
  end

  def destroy
    cookies.delete(:smb_auth_token)
    redirect_to root_url, :notice => "Logged out!"
  end
end
