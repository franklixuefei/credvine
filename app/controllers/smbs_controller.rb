class SmbsController < ApplicationController
  # GET /smbs
  # GET /smbs.json
  def find_conjunction(list_1, list_2, model)
    list = []
    list_1.each do |elem_1|
      list_2.each do |elem_2|
        if elem_1 == elem_2
          list.push(elem_2.id) 
        end
      end  
    end
    t = model.where(:id => list)
    return t
  end
  
  
  before_filter :get_selector
  before_filter :get_text
  
  def get_selector
    if admin?
      if params[:customer_id].present?
        @selector = Customer.find_by_auth_token(params[:customer_id])
      elsif params[:friend_id].present?
        @selector = Friend.find(params[:friend_id])
      end
    end
  end
  
  def get_text
    @term = ""
    file = File.new("public/term.txt", "r")
    while (line = file.gets)
      @term += line
    end
    file.close
  end
  
  def index
    if admin?
      if (params[:customer_id].present? or params[:friend_id].present?)
        @smbs = @selector.smbs
        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @smbs }
        end
      else
        @smbs = Smb.all
        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @smbs }
        end
      end
    else
      flash[:error] = "Not Authorized!"
      redirect_to root_url
    end
  end
  
  # GET /smbs/1
  # GET /smbs/1.json
  def show
    if (params[:customer_id].present? or params[:friend_id].present?)
      @smb = @selector.smbs.find_by_auth_token(params[:id]) 
    else
      @smb = Smb.find_by_auth_token(params[:id])
    end
    # if current_user && current_user.id != params[:id]
      # redirect_to smb_customers_path(current_user)
    # else
    # IMPORTANT: CURRENTLY we don't want show page.
    # respond_to do |format|
      # format.html # show.html.erb
      # format.json { render :json => @smb }
   # end
    redirect_to edit_smb_path(@smb)
  end
  
  # GET /smbs/new
  # GET /smbs/new.json
  def new
    @smb = Smb.new
    #@path = request.fullpath[-3,4]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @smb }
    end
  end
  
  # GET /smbs/1/edit
  def edit
    if current_user
      if current_user.activated
        @smb = current_user #Smb.find(params[:id])
      else 
        flash[:error] = "Please click the link in your inbox to activate your account first"
        redirect_to navigation_smb_path(current_user)
      end
    else
      flash[:error] = "You must login first"
      redirect_to root_url
    end
  end

  # POST /smbs
  # POST /smbs.json
  def create
    @smb = Smb.new(params[:smb])
    @smb.partial_code = SecureRandom.base64(5).delete("=").delete("\n\r").tr("+/", "-_")
    @smb.date_of_payment_for_ref = Date.today
    @smb.activation_token = SecureRandom.base64(10).delete("=").delete("\n\r").tr("+/", "-_")
    s = SignupRequest.find_by_beta_key(params[:bk])
    p = PromoCode.find_by_promo_code(params[:pc])
    @smb.business_type = s.package_type
    @smb.credit = p.promo_credit
    @smb.activated = true; #after out of beta, remove TODO
    respond_to do |format|
      if @smb.save(:validate => false)
        cookies.permanent[:smb_auth_token] = @smb.auth_token # automatically logged in after sign up
        #generate smb partial code
        #@smb.update_attributes(:partial_code => @smb.id.to_s) #need to figure out more sophisticated way to encrypt.
        @smb.promo_codes.push(p)
        #UserMailer.smb_confirm(@smb).deliver # after out of beta, uncomment TODO
        format.html { redirect_to navigation_smb_path(@smb) }
        format.json { render :json => navigation_smb_path(@smb), :status => :created, :location => navigation_smb_path(@smb) }
      else
        format.html { render :action => "new" }
        format.json { render :json => @smb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /smbs/1
  # PUT /smbs/1.json
  def update
    if current_user
      @smb = current_user
      respond_to do |format|
        if params[:refresh] == "0"
          if @smb.update_attributes(params[:smb])
            #UserMailer.smb_confirm(@smb).deliver # for testing
            
            if @smb.first_time
              flash[:notice] = 'Your profile has been successfully created.'
              @smb.profile_completed = true;
              @smb.save
              if @smb.campaign_created
                format.html { redirect_to closer_last_smb_path(@smb) }
                format.json { head :ok }
              else
                format.html { redirect_to closer_smb_path(@smb) }
                format.json { head :ok }
              end
            else
              flash[:notice] = 'Smb was successfully updated.'
              format.html { redirect_to edit_smb_path(@smb) }
              format.json { head :ok }
            end
            
          else
            format.html { render :action => "edit" }
            format.json { render :json => @smb.errors, :status => :unprocessable_entity }
          end
        else
          @smb.attributes = (params[:smb])
          @smb.save(:validate => false)
          format.html { redirect_to edit_smb_path(@smb) }
          format.json { head :ok }
        end
      end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end

  # DELETE /smbs/1
  # DELETE /smbs/1.json
  def destroy
    if (params[:customer_id].nil? and params[:friend_id].nil?)
      if admin?
        @smb = Smb.find_by_auth_token(params[:id])
      elsif current_user?
        @smb = current_user
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path
      end
    end
  end
  
  def redemption
    if current_user
      @smb = current_user
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def redeem
    if current_user
      @smb = current_user  # these Smb.find(params[:id]) will be replaced by current_user, and in application_controller.rb set current_user according to reset password and remember me on railscasts
      respond_to do |format|
        current_code = params[:code]
        if ((current_code.length == 14) or (current_code.length == 21))
          #begin to search in the collection of current smb's codes
          codes = @smb.codes
          found = false
          codes.each do |code|
            if ((code.cust_init_code == current_code) and (code.cust_init_status != "REDEEMED"))
              # to see whether redemption times exceeds request times. (corr. with customers controller)
              if code.customer.cust_init_coupon_redemption_times < code.customer.cust_init_coupon_request_times
                code.update_attributes(:cust_init_status => "REDEEMED")
                flash[:notice] = "code for referral by customer found"
                found = true
                code.customer.cust_init_coupon_redemption_times += 1
                code.customer.save!
              end
              @code = code
              break
            elsif ((code.cust_success_code == current_code) and (code.cust_success_status != "REDEEMED"))
              
              code.update_attributes(:cust_success_status => "REDEEMED")
              #UserMailer.cust_success_redeemed(@smb, code.customer, code.friend, code.campaign, false).deliver
              flash[:notice] = "code for successful customer found"
              found = true
              @code = code
              break
            elsif ((code.frien_code == current_code) and (code.frien_status != "REDEEMED"))
              # here to add the feature to enable customizing thx msg to customer
              code.update_attributes(:frien_status => "REDEEMED")
              UserMailer.frien_redeem(@smb, code.customer, code.friend, code.campaign).deliver
              # if notify me selected in campaign, then send a notification to smb owner
              if code.campaign.notify_me_per_succ_ref
                UserMailer.notification_per_succ_ref(@smb, code.id, code.customer, code.friend, code.campaign).deliver
              else
                code.update_attributes(:cust_success_status => "SENT")
                UserMailer.cust_success(code.temp_final_thx, code, @smb, code.customer, code.friend, code.campaign, false).deliver
              end
              flash[:notice] = "code for friend coupon found"
              found = true
              @code = code
              break
            end
          end
          if found
            # maybe do something here
            format.html {redirect_to :action => 'coupon', :notice => flash[:notice], :cid => @code.identifier }
            format.json {render :json => coupon_smb_path, status => 200, :location => coupon_smb_path}
          else
            flash[:error] = "Coupon code not found or has already been redeemed"
            format.html {redirect_to redemption_smb_path}
            format.json {render :status => :unprocessable_entity}          
          end
        else
          flash[:error] = "Please enter a valid code"
          format.html {redirect_to redemption_smb_path}
          format.json {render :status => :unprocessable_entity}
        end
      end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def redeem_mobile
    code = params[:scanned_code]
    @scanned_code = code
    smb_partial = code[0..6]
    smb = Smb.find_by_partial_code(smb_partial)
    @smb_name = smb.full_name
    @smb_logo_url = smb.logo.url(:medium)
    @smb_token = smb.auth_token
    @smb_logo_filename = smb.logo_file_name
    respond_to do |format|
      format.html {render :layout => "mobile_application"}
    end
  end
  
  def redeeming_mobile
    @smb = Smb.find_by_auth_token(params[:id])
    respond_to do |format|
      current_code = params[:code]
      if @smb.PIN == params[:pin]
        if ((current_code.length == 14) or (current_code.length == 21))
          #begin to search in the collection of current smb's codes
          codes = @smb.codes
          found = false
          codes.each do |code|
            if ((code.cust_init_code == current_code) and (code.cust_init_status != "REDEEMED"))
              # to see whether redemption times exceeds request times. (corr. with customers controller)
              if code.customer.cust_init_coupon_redemption_times < code.customer.cust_init_coupon_request_times
                code.update_attributes(:cust_init_status => "REDEEMED")
                flash[:notice] = "code for referral by customer found"
                found = true
                code.customer.cust_init_coupon_redemption_times += 1
                code.customer.save!
              end
              @code = code
              break
            elsif ((code.cust_success_code == current_code) and (code.cust_success_status != "REDEEMED"))
              
              code.update_attributes(:cust_success_status => "REDEEMED")
              #UserMailer.cust_success_redeemed(@smb, code.customer, code.friend, code.campaign, false).deliver
              flash[:notice] = "code for successful customer found"
              found = true
              @code = code
              break
            elsif ((code.frien_code == current_code) and (code.frien_status != "REDEEMED"))
              # here to add the feature to enable customizing thx msg to customer
              code.update_attributes(:frien_status => "REDEEMED")
              UserMailer.frien_redeem(@smb, code.customer, code.friend, code.campaign).deliver
              # if notify me selected in campaign, then send a notification to smb owner
              if code.campaign.notify_me_per_succ_ref
                UserMailer.notification_per_succ_ref(@smb, code.id, code.customer, code.friend, code.campaign).deliver
              else
                code.update_attributes(:cust_success_status => "SENT")
                UserMailer.cust_success(code.temp_final_thx, code, @smb, code.customer, code.friend, code.campaign, false).deliver
              end
              flash[:notice] = "code for friend coupon found"
              found = true
              @code = code
              break
            end
          end
          if found
            # maybe do something here
            format.html {redirect_to "/voucher_redeemed"}
          else
            flash[:error] = "Coupon code not found or has already been redeemed"
            format.html {redirect_to '/redeem/'+current_code+'?cid='+params[:cid], :error => flash[:error]}
          end
        else
          flash[:error] = "Please enter a valid code"
          format.html {redirect_to '/redeem/'+current_code+'?cid='+params[:cid], :error => flash[:error]}
        end
      else
        flash[:error] = "ERROR: PIN not valid" #TODO do the client side validation
        format.html {redirect_to '/redeem/'+current_code+'?cid='+params[:cid], :error => flash[:error]}
      end
    end
  end
  
  def post_mobile_redemption
    respond_to do |format|
      format.html {render :layout => "mobile_application"}
    end
  end
  
  def change_pin
    @smb = current_user
    password = params[:pin_password]
    user = Smb.authenticate(@smb.email, password)
    if user
      @smb.PIN = params[:new_pin]
      @smb.save(:validate => false)
      render json: ActiveSupport::JSON.encode({:ok => true })
    else
      render json: ActiveSupport::JSON.encode({:ok => false })  
    end
  end
  
  
  def coupon
    if current_user
      @smb = current_user
      @code = Code.find_by_identifier(params[:cid])
      @customer = @code.customer
      @friend = @code.friend
      @campaign = @code.campaign
      @friend_incentive = @code.incentive
       respond_to do |format|
         format.html
        # # format.json {render :json => } 
         format.png { render :qrcode => "A QR Code Encoding Example", :level => :h, :unit => 10 } # TODO qrcode for campaign
       end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def cardinfo
    if current_user
      @smb = current_user
      #if request.xhr?
        #render :html => "cardinfo", :layout => false
      #end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def savecard #almost the same as subscription's create
    if current_user
      current_user.attributes = {:email_for_card => params[:smb][:email_for_card], :stripe_card_token => params[:smb][:stripe_card_token]}
      if current_user.save_card("Auth token: "+current_user.auth_token+"; Company Email: "+current_user.email+"; Company Name: "+current_user.full_name)
         if params[:popup] == "1"
           redirect_to close_window_smb_path(current_user) # redirect to a page to ask user to close this window
         else
           redirect_to current_user # TODO redirect to dashboard later
         end
      else
        render :cardinfo
      end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def editcard
  end

  def updatecard
    if current_user
      current_user.attributes = {:email_for_card => params[:smb][:email_for_card], :stripe_card_token => params[:smb][:stripe_card_token]}
      if current_user.update_card("Auth token: "+current_user.auth_token+"; Company Email: "+current_user.email+"; Company Name: "+current_user.full_name)
        redirect_to current_user # TODO redirect to dashboard later
      else
        render :editcard
      end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def deletecard
    if current_user
      if current_user.card_provided?
        if current_user.destroy_card
          redirect_to current_user #TODO change it to dashboard later
        else
          render :error_page
        end
      else
        # do nothing
      end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def error_page
    
  end
  
  # def activate_campaign
    # if current_user.card_provided?
      # current_user.campaign_activated = true
      # current_user.save!
    # else
      # redirect_to cardinfo_smb_path(current_user), :notice => "Please provide you card information first and try again"
    # end
  # end
  
  def edit_thx_msg_to_succ_cust
    if current_user
      @smb = current_user
      @campaigns = @smb.campaigns.find(:all, :conditions => ['status = ?', true]) # TODO important:!! potentially supports multiple active campaigns.
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def send_thx_msg
    if current_user
      @smb = current_user
      code = Code.find_by_identifier(params[:cid])
      if params[:custom_thx_msg].present?
        code.temp_final_thx = params[:custom_thx_msg]
        code.save!
      end
      # send from temp final thx
      # TODO in the following mailer view, add if @temp_final_thx.present? (send from temp final thx) else (send from final thx) 
      UserMailer.cust_success(code.temp_final_thx, code, @smb, code.customer, code.friend, code.campaign, false).deliver
      code.update_attributes(:cust_success_status => "SENT")
      if params[:custom_thx_msg].present?
        flash[:notice] = "Message successfully sent!"
        redirect_to edit_thx_msg_to_succ_cust_smb_path(@smb)
      else
        redirect_to :action => 'custom_thx_sent', :cid => params[:cid]
      end
         
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path      
    end
  end
  
  def custom_thx_sent
    if current_user
      @smb = current_user
      @customer = Code.find_by_identifier(params[:cid]).customer
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def navigation
    if current_user
      @smb = current_user
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def closer
    if current_user
      if current_user.profile_completed
        @smb = current_user
      else
        if current_user.activated
          flash[:error] = 'You must complete your Business Profile first!'
          redirect_to edit_smb_path(current_user)
        else
          flash[:error] = 'Your account is not activated. Please follow the instructions above'
          redirect_to navigation_smb_path(current_user)
        end
      end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def closer_last
    if current_user
      if current_user.campaign_created
        @smb = current_user
      else
        if current_user.activated
          flash[:error] = 'You must create your campaign first!'
          redirect_to smb_campaigns_path(current_user)
        else
          flash[:error] = 'Your account is not activated. Please follow the instructions above'
          redirect_to navigation_smb_path(current_user)
        end
      end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  # def done
    # if current_user
      # @smb = current_user
      # if current_user.campaign_launched
        # @smb = current_user
        # @smb.first_time = false # turn of first_time flag
        # @smb.save!
      # else
        # flash[:error] = 'You must create your campaign first!'
        # redirect_to smb_campaigns_path(current_user)
      # end
    # else
      # flash[:error] = "You must login first!"
      # redirect_to log_in_path
    # end
  # end
  
  def activate_account
    if current_user && current_user.auth_token == params[:id]
      @smb = current_user
      if params[:activation_token] == @smb.activation_token
        @smb.activated = true
        @smb.save(:validate => false)
        flash[:notice] = "Your account has been activated"
        redirect_to edit_smb_path(@smb)
      else
        flash[:error] = "We are sorry, but activation fails. Please make sure to click the link in the confirmation email."
        redirect_to navigation_smb_path(@smb)  
      end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path
    end
  end
  
  def check_on_file
    if current_user
      @smb = current_user
      render json: ActiveSupport::JSON.encode({:card_on_file => @smb.card_on_file })
    end
  end
  
  def check_old_password
    user = Smb.authenticate(params[:password_reset_email], params[:old_password])
    if user
      render json:ActiveSupport::JSON.encode({:ok => true})
    else
      render json:ActiveSupport::JSON.encode({:ok => false})
    end
  end
  
  def change_password
    user = Smb.authenticate(params[:password_reset_email], params[:old_password])
    if user
      user.password = params[:new_password]
      user.password_confirmation = params[:new_password_confirmation]
      user.save(:validate => false)
      render json:ActiveSupport::JSON.encode({:ok => true})
    else
      render json:ActiveSupport::JSON.encode({:ok => false})
    end
  end
  
  def check_if_username_taken
    if Smb.where(:username => params[:username]).present?
      render json: ActiveSupport::JSON.encode({:ok => false })
    else
      render json: ActiveSupport::JSON.encode({:ok => true })
    end
  end
  
  def check_if_email_taken
    if Smb.where(:email => params[:email]).present?
      render json: ActiveSupport::JSON.encode({:ok => false })
    else
      render json: ActiveSupport::JSON.encode({:ok => true })
    end
  end
  
  def dashboard
    if current_user
      #TODO add if first_time .... then redirect to corresponding page (resembles sessions#create)
      @smb = current_user
      if @smb.campaigns.present?
        @campaign = @smb.campaigns.find(:all, :conditions => ['temp = ? and status = ?', false, true]).first
        @inactive_campaigns = @smb.campaigns.find(:all, :conditions => ['temp = ? and status = ?', false, false]) # find all campaigns that temp=false and status=false
        @num_new_customers = @campaign.codes.find(:all, :conditions => ['frien_status = ?', "REDEEMED"]).count if @campaign.present? # total successful referrals in active campaign
        @num_friend_exposed = @campaign.codes.count if @campaign.present?# total referrals in active campaign
        if @num_friend_exposed.present?
          if @num_friend_exposed != 0
            @conversion_rate = (100 * (@num_new_customers.to_f / @num_friend_exposed.to_f)).round() # conversion rate timed 100.
          else
            @conversion_rate = 0
          end
        end
        unfiltered_customers_in_active_campaign = []
        if @campaign.present? && @campaign.codes.present?
          @campaign.codes.each do |code|
            unfiltered_customers_in_active_campaign.push(code.customer)
          end 
          @customers_in_active_campaign = unfiltered_customers_in_active_campaign.uniq.sort{|customer| customer.codes.count}
        else
          # nothing
        end
      else
        # nothing
      end
    else
      flash[:error] = "You must login first."
      redirect_to log_in_path
    end
  end
  
  def gen_coupon
    
    if @code = Code.find_by_identifier(params[:cid])
      if @code.frien_code == params[:code] or @code.cust_success_code == params[:code] or @code.cust_init_code == params[:code]
        #Smb.convert_to_img("http://credvine.com/smbs/gen_coupon?cid=#{params[:cid]}&code=#{params[:code]}")
        #url = "http://credvine.com/"
        #img = `wkhtmltoimage "#{url}" /home/credvine/webapps/rails/credvine/public/posters/1/poster.png`
        if @code.frien_code == params[:code]
          @long_incentive = @code.incentive.frien_incentive_long
          @terms_of_use = @code.incentive.term_of_use_fi
        elsif @code.cust_success_code == params[:code]
          @long_incentive = @code.campaign.cust_successful_incentive_long
          @terms_of_use = @code.campaign.term_of_use_csi
        elsif @code.cust_init_code == params[:code]
          @long_incentive = @code.incentive.cust_sent_incentive_long
          @terms_of_use = @code.campaign.term_of_use
        end
        respond_to do |format|
          format.html { render :layout => "mobile_application"} # use @code, like @code.campaign ... in view file
          format.png {render :qrcode => "#{root_url}redeem/#{params[:code]}", :color => '66cc00'}
        end
        #render :text => img
      end
   end
  end
  
  def thanks
    render :layout => "mobile_application"
  end
  
  def admin_dashboard
    if admin?
      @admins = Smb.find(:all, :conditions => ['admin = ?', true], :order => "id DESC")
      @users = Smb.find(:all, :order => "id DESC")
      @requests_with_small = SignupRequest.find(:all, :conditions => ['package_type = ? and beta_key IS NOT NULL', 'small'], :order => "id DESC")
      @requests_with_professional = SignupRequest.find(:all, :conditions => ['package_type = ? and beta_key IS NOT NULL', 'professional'], :order => "id DESC")
      @requests_with_enterprise = SignupRequest.find(:all, :conditions => ['package_type = ? and beta_key IS NOT NULL', 'enterprise'], :order => "id DESC")
      @unprocessed_requests = SignupRequest.find(:all, :conditions => ['beta_key is ?', nil], :order => "id DESC")
      approved_requested_users = SignupRequest.find(:all, :conditions => ['beta_key IS NOT NULL'])
      @requested_users_not_signed_up = []
      if approved_requested_users.present?
        approved_requested_users.each do |requested_user|
          if Smb.find_by_email(requested_user.request_email).nil?
            @requested_users_not_signed_up.push(requested_user)
          end
        end
      end
    else
      flash[:error] = "NOT AUTHORIZED"
      redirect_to root_url
    end
  end
  
  def approve
    s = SignupRequest.find(params[:request_id])
    if s.beta_key == nil
      p = PromoCode.create(:promo_code => params[:promo_code], :promo_credit => params[:promo_credit])
      s.beta_key = SecureRandom.base64(10).delete("=").delete("\n\r").tr("+/", "-_")
      s.save
      s.promo_codes.push(p)
      UserMailer.send_invitation(s, p).deliver
      render json: ActiveSupport::JSON.encode({:ok => true })
    else
      render json: ActiveSupport::JSON.encode({:ok => false })
    end
  end
  
  def ignore
    begin
      s = SignupRequest.find(params[:request_id])
      s.destroy
      render json: ActiveSupport::JSON.encode({:ok => true })
    rescue
      render json: ActiveSupport::JSON.encode({:ok => false })
    end
  end
  
  # def check_beta_key
    # s = SignupRequest.find(:all, :conditions => ['beta_key = ? and request_email = ?', params[:beta_key], params[:request_email]])
    # if s.present?
      # render json: ActiveSupport::JSON.encode({:ok => true })
    # else
      # render json: ActiveSupport::JSON.encode({:ok => false })
    # end
  # end
# 
  # def check_promo_code
    # p = PromoCode.find(:all, :conditions => ['promo_code = ?', params[:promo_code]])
    # if p.present?
      # render json: ActiveSupport::JSON.encode({:ok => true })
    # else
      # render json: ActiveSupport::JSON.encode({:ok => false })
    # end
  # end
  
  def check_all
    h = {:username_ok => false, :email_ok => false, :betakey_ok => false, :promocode_ok => false}
    if Smb.where(:username => params[:username]).present?
      h[:username_ok] = false
    else
      h[:username_ok] = true
    end
    
    if Smb.where(:email => params[:email]).present?
      h[:email_ok] = false
    else
      h[:email_ok] = true
    end
    
    s = SignupRequest.find(:all, :conditions => ['beta_key = ? and request_email = ?', params[:beta_key], params[:email]])
    if s.present?
      h[:betakey_ok] = true
    else
      h[:betakey_ok] = false
    end
    
    p = PromoCode.find(:all, :conditions => ['promo_code = ?', params[:promo_code]])
    if p.present? && p.first.smb_id == nil
      h[:promocode_ok] = true
    else
      h[:promocode_ok] = false
    end
    render json: ActiveSupport::JSON.encode(h)
  end
  
  def poster
    @smb = Smb.find_by_auth_token(params[:id])
      respond_to do |format|
         format.html {render :layout => false} # use @code, like @code.campaign ... in view file
         format.png {render :qrcode => "credvine.com/#{@smb.username}", :color => :black, :unit => 7}
      end
    
  end
  
  def referral_card
    @smb = Smb.find_by_auth_token(params[:id])
       respond_to do |format|
         format.html {render :layout => false} # use @code, like @code.campaign ... in view file
         format.png {render :qrcode => "credvine.com/#{@smb.username}", :color => :black, :unit => 9}
      end
  end
  
  def fetch_request
    s = SignupRequest.find(params[:req_id])
    h = {:req_email => s.request_email, :bk => s.beta_key, :sent_at => Time.parse(s.created_at.to_s).strftime("%b %e, %Y at %I:%M%p UTC"), :type => s.package_type, :pcs => s.promo_codes, :approved_at => Time.parse(s.updated_at.to_s).strftime("%b %e, %Y at %I:%M%p UTC") }
    render json: ActiveSupport::JSON.encode(h)
  end
  
  def fetch_smb_user_data
    begin
      s = Smb.find(params[:user_id])
    rescue
      render json:ActiveSupport::JSON.encode({:ok => false}) and return
    end
    s[:pcs] = s.promo_codes
    if s.business_catagory.present?
      s[:biz_category] = s.business_catagory.business
    else
      s[:biz_category] = nil
    end
    s[:logo_url] = s.logo.url(:small)
    s[:featured_photo_url] = s.featured_photo.url(:small)
    if s.state.present?
      s[:state_name] = s.state.name
    else
      s[:state_name] = ''
    end
    if s.country.present?
      s[:country_name] = s.country.name
    else
      s[:country_name] = ''
    end
    if s.linkedin_url.present?
      s[:linkedin_url] = 'http://' + s.linkedin_url.gsub(/http:\/\//, "")
    else
      s[:linkedin_url] = nil
    end
    if s.yelp_url.present?
      s[:yelp_url] = 'http://' + s.yelp_url.gsub(/http:\/\//, "")
    else
      s[:yelp_url] = nil
    end
    if s.twitter_url.present?
      s[:twitter_url] = 'http://' + s.twitter_url.gsub(/http:\/\//, "")
    else
      s[:twitter_url] = nil
    end
    if s.facebook_url.present?
      s[:facebook_url] = 'http://' + s.facebook_url.gsub(/http:\/\//, "")
    else
      s[:facebook_url] = nil
    end
    if s.site_url.present?
      s[:site_url] = 'http://' + s.site_url.gsub(/http:\/\//, "")
    else
      s[:site_url] = nil
    end
    unless s.state.present?
      s[:state_id] = nil
    end
    s[:ok] = true
    render json:ActiveSupport::JSON.encode(s)
  end
  
  def gen_promocode
    c = PromoCode.generate_promocode
    render json:ActiveSupport::JSON.encode({:p_code => c})
  end
  
  def add_promocode
    begin
      s = Smb.find(params[:userid])
    rescue
      render json:ActiveSupport::JSON.encode({:ok => false, :deleted => true}) and return
    end
    p = PromoCode.create(:promo_code => params[:p_code], :promo_credit => params[:p_credit].to_s)
    # no need to link SignupRequest
    if s.credit != "free"
      s.promo_codes.push(p)
      s.credit = (s.credit.to_i + params[:p_credit].to_i).to_s
      s.save(:validate => false)
      render json:ActiveSupport::JSON.encode({:ok => true, :p => p})
    else
      render json:ActiveSupport::JSON.encode({:ok => false})
    end
  end
  
  def del_promocode
    begin
      s = Smb.find(params[:u_id])
    rescue
      render json:ActiveSupport::JSON.encode({:ok => false, :deleted => true}) and return
    end
    if s.credit != "free"
      p = s.promo_codes.find(params[:p_id])
      p.destroy
      s.credit = (s.credit.to_i - p.promo_credit.to_i).to_s
      s.save(:validate => false)
      render json:ActiveSupport::JSON.encode({:ok => true, :p => p})
    else
      render json:ActiveSupport::JSON.encode({:ok => false})
    end
  end
  
  def set_admin
    begin
      s = Smb.find(params[:userid])
    rescue
      render json:ActiveSupport::JSON.encode({:deleted => true}) and return
    end
    if params[:button_status] == "to_admin"
      s.admin = true
    else
      s.admin = false
    end
    s.save(:validate => false)
    render json:ActiveSupport::JSON.encode({:admin => s.admin})
  end
  
  def del_smb
    begin
      s = Smb.find(params[:userid])
      s.destroy
      render json:ActiveSupport::JSON.encode({:ok => true})
    rescue
      render json:ActiveSupport::JSON.encode({:ok => false})
    end
  end
  
  def set_payment
    begin
      s = Smb.find(params[:userid])
    rescue
      render json:ActiveSupport::JSON.encode({:deleted => true}) and return
    end
    if params[:button_status] != "to_pay"
      s.temp_credit = s.credit
      s.credit = 'free'
    else
      s.credit = s.temp_credit
    end
    s.save(:validate => false)
    render json:ActiveSupport::JSON.encode({:credit => s.credit})
  end
  
  def resend_send
    s = SignupRequest.find(params[:request_id])
    p = s.promo_codes.first #there is only one promo code possible
    UserMailer.send_invitation_customized(s, p, params[:resend_subject], params[:resend_from], params[:resend_message]).deliver;
    render json:ActiveSupport::JSON.encode({:ok => true})
  end
  
  def pull_email_text
    s = SignupRequest.find(params[:request_id])
    p = s.promo_codes.first #there is only one promo code possible
    if p.promo_credit == 0
      text = "The invitation you requested to Credvine Referrals has been confirmed. Please click <a href=#{sign_up_url(:host => "credvine.com", :bk => s.beta_key, :pc => p.promo_code)}>here</a> to get started."
    elsif p.promo_credit != "free"
      text = "The invitation you requested to Credvine Referrals has been confirmed. Please click <a href=#{sign_up_url(:host => "credvine.com", :bk => s.beta_key, :pc => p.promo_code)}>here</a> to get started. We've added a special credit of $... to your account!"
    else
      text = "The invitation you requested to Credvine Referrals has been confirmed. Please click <a href=#{sign_up_url(:host => "credvine.com", :bk => s.beta_key, :pc => p.promo_code)}>here</a> to get started with your special beta tester account, which will be free for the first 2 months."
    end
    render json: ActiveSupport::JSON.encode({:ok => true, :importantParagraph => text })
  end
  
  def del_pic
    smb = Smb.find_by_auth_token(params[:id])
    if params[:picType] == "profile"
      smb.logo.destroy
      smb.save!(:validate => false)
      render json: ActiveSupport::JSON.encode({:ok => true})
    elsif params[:picType] == "featured"
      smb.featured_photo.destroy
      smb.save!(:validate => false)
      render json:ActiveSupport::JSON.encode({:ok => true})
    else
      render json:ActiveSupport::JSON.encode({:ok => false})
    end
  end
  
end
