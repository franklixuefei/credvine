class Smb < ActiveRecord::Base

  attr_accessible :password_reset_token, :password_reset_sent_at, :username, :per_success, :auth_token, :full_name, :email, :password, :password_confirmation, :logo, :abbr_name, :catagory, :industry, :st_name_num, :suite_num,  :zip_pos, :phone, :partial_code, :country_id, :state_id, :business_catagory_id, :city, :state_prov, :email_for_card, :stripe_card_token, :stripe_customer_token, :card_on_file, :date_of_payment_for_ref, :campaign_activated, :num_of_codes_to_pay, :cust_init_coupon_request_times, :cust_init_coupon_redemption_times, :cust_init_sent_at, :num_of_succ_codes_to_pay, :admin, :activated, :first_time, :profile_completed, :campaign_confirmed,:campaign_launched, :activation_token, :featured_photo, :site_url, :facebook_url, :twitter_url, :linkedin_url, :yelp_url, :business_description, :business_type, :credit, :temp_credit, :PIN, :campaign_created, :insert_map, :Terms_and_Conditions
  attr_accessor :password, :stripe_card_token, :term_and_conditions, :Terms_and_Conditions
  before_save :encrypt_password
  before_save :set_state_id
  before_create { generate_token(:auth_token) }
  #before_save :downcase_username_email

  # before_save :generate_partial_code
  validates_confirmation_of :password
  validates_presence_of :username, :full_name, :email, :country_id, :business_catagory_id
  validates_presence_of :password, :on => :create
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_length_of :phone, :maximum => 16
  validates_length_of :password, :minimum => 4, :allow_blank => true
  
  validates_uniqueness_of :username, :email
  validates :email, :email_format => true
  has_and_belongs_to_many :customers
  has_many :campaigns, :dependent => :delete_all
  has_and_belongs_to_many :friends
  has_many :codes, :dependent => :delete_all
  has_many :subscriptions, :dependent => :delete_all
  has_many :promo_codes, :dependent => :delete_all
  has_attached_file :logo,
    :default_url => '/assets/no_photo.jpg',
    :styles => {
        :large => "700x700>",
        :medium => "500x375>",
        :small => "200x200>",
        :thumb => "50x50>"
    },
    :url => "/assets/smbs/:id/logo/:style/:basename.:extension",
    :path => ":rails_root/public/assets/smbs/:id/logo/:style/:basename.:extension"
  has_attached_file :featured_photo,
    :default_url => '/assets/no_photo.jpg',
    :styles => {
        :large => "700x700>",
        :medium => "500x370>",
        :small => "200x200>",
        :thumb => "50x50>"
    },
    :url => "/assets/smbs/:id/featured_photo/:style/:basename.:extension",
    :path => ":rails_root/public/assets/smbs/:id/featured_photo/:style/:basename.:extension"
  
  #validates_attachment_presence :logo
  #validates_attachment_presence :featured_photo
  validates_attachment_size :logo, :less_than => 400.kilobytes
  validates_attachment_size :featured_photo, :less_than => 400.kilobytes
  validates_attachment_content_type :logo, :content_type => /image/
  validates_attachment_content_type :featured_photo, :content_type => /image/
  has_one :report
  has_one :data_file, :dependent => :delete
  belongs_to :country
  belongs_to :state
  belongs_to :business_catagory
  validates :Terms_and_Conditions, :acceptance => true
  
  def set_state_id
    if state_prov.present?
      self.state_id = nil
    end
  end
  
  def to_param
    auth_token
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.base64.delete("=").delete("\n\r").tr("+/", "-_")
    end while Smb.exists?(column => self[column])
  end
  
  # def downcase_username_email
    # self.username = username.downcase
    # self.email = email.downcase
  # end

  
  def self.authenticate(email, password)
    user = find(:all, :conditions => ['email = ? or username = ?', email, email], :limit => 1).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def card_provided?
    stripe_card_token.present? || card_on_file
  end
  
  def save_card(description)
    if stripe_customer_token.present? #actually this kind of situation does not exist. because when delete a card, the card user is actually deleted from Stripe. So when save card, stripe card token must be nil
      customer = Stripe::Customer.retrieve(stripe_customer_token)
      customer.card = stripe_card_token
      customer.save
    else
      customer = Stripe::Customer.create(:description => description, :email => email_for_card, :card => stripe_card_token)
      self.stripe_customer_token = customer.id
    end
    self.card_on_file = true
    save!
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card: #{e.message}"
    false
  end
  
  def update_card(description)
    customer = Stripe::Customer.retrieve(stripe_customer_token)
    customer.email = email_for_card
    customer.card = stripe_card_token
    customer.save
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while updating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card: #{e.message}"
    false
  end
  
  def destroy_card # currently unable to delete a card
    customer = Stripe::Customer.retrieve(stripe_customer_token)
    customer.delete
    self.stripe_customer_token = ""
    self.card_on_file = false
    save!
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while deleting customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card: #{e.message}"
    false
  end

  def charge_ref_payment(smb_codes)
    # if per successful ref chosen  TODO
    # else if per ref chosen
    
    if per_success # if user chooses to pay per successful referral
      remaining_credit = credit.to_i - num_of_succ_codes_to_pay * 4.99      
      if remaining_credit < 0
        self.credit = 0
        save!
        charge = Stripe::Charge.create(:amount => (-1) * remaining_credit, :currency => 'usd', :customer => stripe_customer_token, :description => "Pay per successful referral, # of referrals paid: "+num_of_succ_codes_to_pay.to_s)
      else
        self.credit = remaining_credit
        save!
      end
    else
      remaining_credit = credit.to_i - num_of_codes_to_pay * 0.25 
      if remaining_credit < 0
        self.credit = 0
        save!
        charge = Stripe::Charge.create(:amount => (-1) * remaining_credit, :currency => 'usd', :customer => stripe_customer_token, :description => "Pay per referral sent, # of referrals paid: "+num_of_codes_to_pay.to_s)
      else
        self.credit = remaining_credit
        save!
      end
    end
    if charge.paid != false
      smb_codes.each do |code| # update the codes' paid status (make codes unpaid to be paid no matter which choice is selected(per_success or not))
        code.paid = true
        code.save!
        #TODO maybe send email to users here (UserMailer....)
      end
    else
      #do nothing
    end
    self.num_of_codes_to_pay -=  smb_codes.count # decrease codes to pay
    self.date_of_payment_for_ref = Date.today # update the pay date
    save!
    rescue Stripe::InvalidRequestError => e
      UserMailer.charge_failed(self, e.message).deliver
      self.campaign_activated = false
      logger.error "Stripe error while charging customer: #{e.message}"
      save!
    rescue Stripe::CardError => e
      UserMailer.charge_failed(self, e.message).deliver
      self.campaign_activated = false
      logger.error "Stripe error while charging customer: #{e.message}"
      save!
  end
  
  def email_send # for testing
    UserMailer.test_unit(self.email).deliver
    return "sent to #{self.email}"
  end
  
  
  

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  

  
  # def self.convert_to_img(url)
    # kit = IMGKit.new(url)
    # kit.to_file("/home/credvine/webapps/rails/credvine/coupon.png")
  # end
#   
  # def self.calculate_credit(smb)
    # total_credit = 0
    # if smb.promo_codes.present?
      # smb.promo_codes.each do |promo_code|
        # total_credit += promo_code.promo_credit.to_i
      # end
    # end
    # return total_credit.to_s
  # end
  
end
