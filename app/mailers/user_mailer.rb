class UserMailer < ActionMailer::Base
  layout 'email'
  
  default :from => "Credvine <noreply@credvine.com>"
  
  # confirmation email after signup
  def smb_confirm(user)
    @smb = user
    mail(:to => user.email, :subject => "Registration Confirmation")
  end
  
  # for testing
  def test_unit(email)
    mail(:to => email, :subject => 'test')
  end
  
  
  # send after a customer send a referral to a friend
  def cust_init(code, smb, customer, friend, campaign, sent)
    @code = code
    @smb = smb
    @customer = customer
    @friend = friend
    @campaign = campaign
    @sent = sent
    if friend.present?
      mail(:to => customer.email, :subject => campaign.init_thx_subject.gsub(/\[Friend First Name\]/, @friend.fullname.split(' ').first).gsub(/\[Business Name\]/, smb.full_name), :from => "#{smb.full_name} <#{smb.email}>")
    else
      mail(:to => customer.email, :subject => campaign.init_thx_subject.gsub(/\[Friend First Name\]/, "your friend").gsub(/\[Business Name\]/, smb.full_name), :from => "#{smb.full_name} <#{smb.email}>")
    end
  end
  
  # send after a customer successfully refers a friend (this friend redeemed his code)
  def cust_success(temp_final_thx, code, smb, customer, friend, campaign, sent)
    @temp_final_thx = temp_final_thx
    @sent = sent
    @code = code
    @smb = smb
    @customer = customer
    @friend = friend
    @campaign = campaign
    mail(:to => customer.email, :subject => campaign.final_thx_subject.gsub(/\[Friend Full Name\]/, friend.fullname), :from => "#{smb.full_name} <#{smb.email}>")
  end
  
  # send to a friend after a customer refers to this friend
  def frien_welc(code, incentive, smb, customer, friend, campaign, sent)
    @sent = sent
    @code = code
    @smb = smb
    @customer = customer
    @friend = friend
    @campaign = campaign
    @incentive = incentive
    mail(:to => friend.email, :subject => campaign.friend_welc_header_subject.gsub(/\[Business Name\]/, smb.full_name), :from => "#{customer.fullname} <#{customer.email}>")
  end
  
  # send after a friend redeems his code
  def frien_redeem(smb, customer, friend, campaign)
    @smb = smb
    @customer = customer
    @friend = friend
    @campaign = campaign
    mail(:to => friend.email, :subject => campaign.thx_frien_subject, :from => "#{smb.full_name} <#{smb.email}>")
  end
  
  # send after a customer redeems his code
  def cust_success_redeemed(smb, customer, friend, campaign, sent)
    @smb = smb
    @customer = customer
    @friend = friend
    @campaign = campaign
    @sent = sent
    mail(:to => customer.email, :subject => "Thanks for coming to #{smb.full_name}", :from => "#{smb.full_name} <#{smb.email}>")
  end
  
  # send to smb owner after selecting notify me in campaign
  def notification_per_succ_ref(smb, code_id, customer, friend, campaign)
    @smb = smb
    @customer = customer
    @friend = friend
    @campaign = campaign
    @code_id = code_id
    mail(:to => smb.email, :subject => "Successful Referral Notification")
  end
  
  def send_invitation(request, promo)
    @request = request
    @promo = promo
    mail(:to => request.request_email, :subject => "Welcome to Credvine Referrals.", :from => "Credvine Signup <signup@credvine.com>")
  end
  
  def send_invitation_customized(request, promo, subject, from, customized_text)
    @request = request
    @promo = promo
    @customized_text = customized_text
    mail(:to => request.request_email, :subject => subject, :from => from)
  end
  
  def charge_failed(smb, message)
    @message = message
    @smb = smb
    mail(:to => smb.email, :subject => "Charge Failure", :from => "Credvine Support <support@credvine.com>")
  end
  
  def request_notification(email)
    mail(:to => email, :subject => "Thanks for requesting to sign up for Credvine Referrals Beta Program", :from => "Credvine Signup <signup@credvine.com>")
  end
  
  def password_reset(smb)
    @smb = smb
    mail :to => smb.email, :subject => "Credvine Password Reset"
  end
end
