class WelcomeController < ApplicationController
  def index
    @title = ' - Home'
    # if current_user
      # redirect_to dashboard_smb_path(current_user) 
    # end
  end
  
  def hiw
    @title = ' - How It Works'
  end
  
  def pricing
    @title = ' - Pricing'
  end
  
  def contact
    @title = ' - Contact'
  end
  
  def invite
    if params[:request_email] =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i 
      if SignupRequest.find(:all, :conditions => ['request_email = ?', params[:request_email]]).empty?
        SignupRequest.create(:request_email => params[:request_email], :package_type => params[:package_type]) 
        UserMailer.request_notification(params[:request_email]).deliver
        RequestMailer.send_request(params[:request_email], params[:package_type], "elissa@credvine.com").deliver
        RequestMailer.send_request(params[:request_email], params[:package_type], "andrew@credvine.com").deliver
        RequestMailer.send_request(params[:request_email], params[:package_type], "frank@referralhook.com").deliver # remove this later TODO
        render json: ActiveSupport::JSON.encode({:ok => true })
      else
        render json: ActiveSupport::JSON.encode({:ok => false })
      end
    end
  end
  
  def terms
    @title = ' - Terms and Conditions'
  end
  
  def about
     @title = ' - About'
  end
  
  def privacypolicy
     @title = ' - Privacy Policy'
  end
  
  def contact_send
    ContactMailer.send_contact_message(params[:contact_name], params[:contact_email], params[:contact_subject], params[:contact_message]).deliver
    render json: ActiveSupport::JSON.encode({:ok => true})
  end
  
  def faqs
    @title = ' - FAQs'
  end
  
  def books_resources
    @title = ' - Referral Books and Resources'
  end

end
