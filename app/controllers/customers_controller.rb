require 'rubygems'
require 'roo'

class CustomersController < ApplicationController
  # GET /customers
  # GET /customers.json
  def find_conjunction(list_1, list_2, list_3=nil)
    list = []
    list_1.each do |elem_1|
      list_2.each do |elem_2|
        if list_3 != nil
          list_3.each do |elem_3|
            if ((elem_1 == elem_2) and (elem_2 == elem_3))
              list.push(elem_1.id) 
            end
          end
        else
          if (elem_1 == elem_2)
            list.push(elem_1.id)
          end
        end
      end  
    end
    t = Code.where(:id => list)
    return t
  end
  
  # before_filter :prepare_for_mobile, :only => :new
  before_filter :get_selector
  
    # def prepare_for_mobile
      # session[:mobile_param] = params[:mobile] if params[:mobile]
      # request.format = :mobile if mobile_device?
    # end
  
  def get_selector
    if params[:smb_id].present?
        @selector = Smb.find_by_auth_token(params[:smb_id])
    elsif params[:username].present? # for customer#new (referral form) use.
        @ref_form_selector = Smb.find_by_username(params[:username])
    elsif params[:friend_id].present?
      if admin?
        @selector = Friend.find(params[:friend_id]) # TODO just a reminder: if not admin, a 500 page will pop up
      end
    end
    
  end
  
  def index
    if params[:smb_id].present?
      if current_user
        @customers = current_user.customers
        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @customers }
        end
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path
      end
    elsif params[:friend_id].present?
      @customers = @selector.customers
        respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @customers }
      end
    else
      if admin?
        @customers = Customer.all
      end
    end
    
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    if params[:smb_id].present?
      if current_user
        @customer = @selector.customers.find_by_auth_token(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render :json => @customer }
        end
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path
      end
    elsif params[:friend_id].present?
      @customer = @selector.customers.find_by_auth_token(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @customer }
      end
    else
      if admin?
        @customer = Customer.find_by_auth_token(params[:id])
      end
    end
    
    
  end

  # GET /customers/new
  # GET /customers/new.json

  def new
    @customer = Customer.new
    1.times {@customer.codes.build}
    @friend = @customer.friends.build
    @assignment = @customer.assignments.build
    
    session[:temp_smb_id] = @ref_form_selector.id
    
    respond_to do |format|
      format.html {render :layout => "mobile_application"} # new.html.erb with mobile_application.html.erb in layouts
      #format.json { render :json => @customer}
    end
    
  end

  # GET /customers/1/edit
  def edit
    if params[:smb_id].present?
      if current_user
        @customer = @selector.customers.find(params[:id])
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path and return
      end
    elsif params[:friend_id].present?
      @customer = @selector.customers.find(params[:id])
    else
      if admin?
        @customer = Customer.find(params[:id])
      end
    end
    render :layout => "mobile_application"
  end

  # POST /customers
  # POST /customers.json
  def create
    if active_campaign = @selector.campaigns.find_by_status(true)
      @active_campaign = active_campaign
    
      @email_of_customer = Customer.where(:email => params[:customer][:email])
      if @email_of_customer.empty?
        #@customer = Customer.new(params[:customer])
        @customer = Customer.new()
        #@customer.username = params[:customer][:username]
        @customer.fullname = params[:customer][:fullname]
        #@customer.phone = params[:customer][:phone]
        @customer.email = params[:customer][:email]
        #@customer.photo = params[:customer][:photo] # to be edited
        @customer.frien_welc = params[:customer][:frien_welc]
        @customer.auth_token = params[:customer][:auth_token]
        # Generate partial codes.
        @customer.partial_code = SecureRandom.base64(5).delete("=").delete("\n\r").tr("+/", "-_")
      else
        # Just update attributes (need discussion) without saving for now
        @customer = @email_of_customer.first
        @customer.fullname = params[:customer][:fullname]
        @customer.frien_welc = params[:customer][:frien_welc]
        #@customer.phone = params[:customer][:phone]
      end
      # tested
      if !session[:auth] # if not logged in to facebook, do the normal things
        @email_of_friend = Friend.where(:email => params[:customer][:friends_attributes]['0'][:email])
        if @email_of_friend.empty?
          @friend = Friend.new(params[:customer][:friends_attributes]['0'])
          # Generate partial codes.
          @friend.partial_code = SecureRandom.base64(5).delete("=").delete("\n\r").tr("+/", "-_")
        else
          @friend = @email_of_friend.first
          @friend.attributes = {:fullname => params[:customer][:friends_attributes]['0'][:fullname]}
        end
        # @friend.save!
        # @customer.save! 
        respond_to do |format|
          if (@customer.save and @friend.save)
            
            if @selector.customers.where(:id => @customer.id).empty? #push customer to smb
              @selector.customers.push(@customer) # link!
            end
            
              #generate friend partial code
              #@friend.update_attributes(:partial_code => @friend.id)
              #insert codes to codes table
              #smb's partial code is already created after sign_up
              #complete_code = @selector.partial_code.to_s+@customer.partial_code.to_s+@friend.partial_code.to_s, :cust_success_code => @selector.partial_code.to_s+@customer.partial_code.to_s
              #if the code matches one in codes table (SAME cust refers SAME friend to SAME smb, all partial codes are the same)
              # TODO: create corresponding mail in view/user_mailer
              #random_partial is for distinguishing codes generated by same customer refering diff friends to same smb.
              random_partial = SecureRandom.base64(5).delete("=").delete("\n\r").tr("+/", "-_")
              # a efficient way to find the matching code without looping
              codes = find_conjunction(@selector.codes, @customer.codes, @friend.codes)
              if codes.present?
                code = codes.first #actually there can only be 1 element in codes
              #if code = Code.find_by_smb_partial_and_cust_partial_and_frien_partial(@selector.partial_code, @customer.partial_code, @friend.partial_code) #1
                if code.cust_init_status == "SENT"
                  #update the status attribute to SENT_AGAIN
                  code.update_attributes(:cust_init_status => "SENT_AGAIN")
                  #send customer initial thank-you mail(in campaign creation) with init coupon code again.
                  UserMailer.cust_init(code, @selector, @customer, @friend, @active_campaign, true).deliver
                elsif code.cust_init_status == "REDEEMED"
                  #nothing sent
                end
                if code.frien_status == "SENT" #friend referral sent but not redeemed yet
                  code.update_attributes(:frien_status => "SENT_AGAIN")
                  #need customer's friend welcome/referral email text this time 
                  UserMailer.frien_welc(code, code.incentive.frien_incentive, @selector, @customer, @friend, @active_campaign, true).deliver
                  # friend has not yet redeemed the code, so cust_success_status MUST BE SENT ONLY.
                  # if code.cust_success_status == "NOT_SENT" #optional to write if here, because the status is bond to be NOT_SENT.
                    # #nothing sent
                  # end
                elsif code.frien_status == "REDEEMED"
                  # Nothing Sent
                  # SAME customer refers the SAME company to the SAME friend, so this customer's success email MUST HAVE ALREADY BEEN SENT.
                  if code.cust_success_status == "SENT"
                    code.update_attributes(:cust_success_status => "SENT_AGAIN")
                    UserMailer.cust_success(code.temp_final_thx, code, @selector, @customer, @friend, @active_campaign, true).deliver
                  elsif code.cust_success_status == "REDEEMED"
                    UserMailer.cust_success_redeemed(@selector, @customer, @friend, @active_campaign, true).deliver
                  end
                end
              else #2
                new_code = Code.new()
                # if code = Code.find_by_smb_partial_and_cust_partial(@selector.partial_code, @customer.partial_code)    #2
                  # #if finally want the functionality to refer multiple friends at one time, just loop through every friend, but use the same random_partial,
                  # #because we only want to give that customer one init code per time (to avoid abusing refering functionality).
                  # new_code.smb_partial = code.smb_partial #SAME smb_partial
                  # new_code.cust_partial = code.cust_partial #SAME cust_partial
                  # new_code.frien_partial = @friend.partial_code #diff friend partial
                # elsif code = Code.find_by_smb_partial_and_frien_partial(@selector.partial_code, @friend.partial_code)  #3
                  # new_code.smb_partial = code.smb_partial #SAME smb_partial
                  # new_code.frien_partial = code.frien_partial #SAME frien_partial
                  # new_code.cust_partial = @customer.partial_code #diff cust_partial
                # elsif code = Code.find_by_cust_partial_and_frien_partial(@customer.partial_code, @friend.partial_code) #4
                  # new_code.cust_partial = code.cust_partial #SAME cust_partial
                  # new_code.frien_partial = code.frien_partial #SAME frien_partial
                  # new_code.smb_partial = @selector.partial_code #diff cust_partial
                # elsif code = Code.find_by_smb_partial(@selector.partial_code)                                          #5
                  # new_code.smb_partial = code.smb_partial #SAME smb_partial
                  # new_code.cust_partial = @customer.partial_code #diff cust_partial
                  # new_code.frien_partial = @friend.partial_code #diff frien_partial
                # elsif code = Code.find_by_cust_partial(@customer.partial_code)                                         #6
                  # new_code.cust_partial = code.cust_partial #SAME cust_partial
                  # new_code.frien_partial = @friend.partial_code #diff frien_partial
                  # new_code.smb_partial = @selector.partial_code #diff smb_partial
                # elsif code = Code.find_by_frien_partial(@friend.partial_code)                                          #7
                  # new_code.frien_partial = code.frien_partial #SAME frien_partial
                  # new_code.cust_partial = @customer.partial_code #diff cust_partial
                  # new_code.smb_partial = @selector.partial_code #diff smb_partial
                # else
                
                # push the partials codes                                                                                                   #8
                new_code.frien_partial = @friend.partial_code
                new_code.cust_partial = @customer.partial_code
                new_code.smb_partial = @selector.partial_code
                # then push the complete codes
                new_code.cust_success_code = new_code.smb_partial+new_code.cust_partial+random_partial
                new_code.frien_code = new_code.smb_partial+new_code.cust_partial+new_code.frien_partial
                new_code.cust_init_code = new_code.smb_partial+new_code.cust_partial
                new_code.save(:validate => false)
                # Then create links !
                @selector.codes.push(new_code)
                @customer.codes.push(new_code)
                @friend.codes.push(new_code)
                @active_campaign.codes.push(new_code)
                # push new code to incentives, to be tested.
                if params[:customer][:codes_attributes]['0'][:incentive_id].present?
                  @selected_incentive = @active_campaign.incentives.find(params[:customer][:codes_attributes]['0'][:incentive_id])
                  @selected_incentive.codes.push(new_code) 
                end
                
                #if new_code.cust_init_status == "SENT" #optional, no other possibilities
                
                #if (Time.parse(Time.now.to_s) - Time.parse(@customer.cust_init_sent_at.to_s))/3600 > 6 # meaning limiting to 4 times a day (every 6 hours)
                @customer.cust_init_coupon_request_times += 1
                UserMailer.cust_init(new_code, @selector, @customer, @friend, @active_campaign, false).deliver
                @customer.cust_init_sent_at = Time.now
                @customer.save!
                #end
                #end
                #if new_code.frien_status == "SENT" #optional, no other possibilities
                  #need customer's friend welcome/referral email text this time              
                UserMailer.frien_welc(new_code, new_code.incentive.frien_incentive, @selector, @customer, @friend, @active_campaign, false).deliver
                new_code.frien_status = "SENT"
                new_code.save!
                #end
              end
              
              if @selector.friends.where(:id => @friend.id).empty? #push friend to smb
                @selector.friends.push(@friend)
              end
              if @customer.friends.where(:id => @friend.id).empty? #push friend to customer
                @customer.friends.push(@friend)
              end
              if params[:customer][:send_to_another] == "0"
                format.html { redirect_to "/#{@selector.username}/#{@customer.auth_token}/sent" } 
                #format.mobile { redirect_to "/m_sent" }
                #format.json { render :json => [@selector, @customer], :status => :created, :location => [@selector, @customer]}
              else
                flash[:customer] = params[:customer]  
                flash[:notice] = "Referral sent successfully!"
                format.html { redirect_to "/#{@selector.username}" }
                #format.mobile { redirect_to "/#{@selector.username}?mobile=1" }
                #format.json { render :json => new_smb_customers_path(@ref_form_selector), :status => :created, :location => new_smb_customers_path(@ref_form_selector)}
              end      
          else
            flash[:error] = "Something wrong. Please resend."
            format.html { redirect_to "/#{@selector.username}" }
            #format.mobile { redirect_to "/#{@selector.username}?mobile=1" }
            #format.json { render :json => @customer.errors, :status => :unprocessable_entity }
          end
        end
        
      else # if logged in to facebook
        #@customer.partial_code = SecureRandom.base64(5).delete("=").delete("\n\r").tr("+/", "-_")
        if params[:customer][:avatar_url].present?
          @customer.avatar_url = params[:customer][:avatar_url]
        end
        respond_to do |format|
          if @customer.save
            
            if @selector.customers.where(:id => @customer.id).empty? #push customer to smb
              @selector.customers.push(@customer) # link!
            end
            
            # TODO: create corresponding mail in view/user_mailer
            #random_partial is for distinguishing codes generated by same customer refering diff friends to same smb.
            random_partial = SecureRandom.base64(5).delete("=").delete("\n\r").tr("+/", "-_")
            # a efficient way to find the matching code without looping
            codes = find_conjunction(@selector.codes, @customer.codes)
            if codes.present?
              # use a pointer to point the codes entries with same smb partial and customer partial, and label it with cust_token for friend side tracking
              # p = Pointer.create(:cust_token => @customer.auth_token)
              # codes.each do |code|
                # p.codes.push(code)
              # end
              # IMPORTANT HERE: UNABLE TO SEND CUST_SUCC EMAIL RIGHT NOW, BECAUSE WE DONT KNOW WHICH CODE WE ARE MANIPULATING WITHOUT KNOWING THE FRIEND.
              new_code = codes.first # only for the purpose of sending cust_init email!!!
              format.html { redirect_to "http://www.facebook.com/dialog/send?app_id=327499717302273&name=I found something I think you\'ll love. Check out " + @selector.full_name + "&link=http://credvine.com/smbs/#{@selector.auth_token}/customers/#{@customer.auth_token}/friends/new?iid=#{params[:customer][:codes_attributes]['0'][:incentive_id].to_s}&picture=http://credvine.com/credvine_logo.png&description=I'm sending along a voucher with a special perk for your first visit - get it here: \n http://credvine.com/smbs/" + @selector.auth_token + "/customers/" + @customer.auth_token + "/friends/new?iid=" + params[:customer][:codes_attributes]['0'][:incentive_id].to_s + "&redirect_uri=http://credvine.com/thanks?user=" + @selector.username }
              #format.mobile { redirect_to "http://www.facebook.com/dialog/send?app_id=327499717302273&name=Hey! Check out " + @selector.full_name + "&link=http://credvine.com&description=Go to this link to get your coupon!\n http://credvine.com/smbs/" + @selector.auth_token + "/customers/" + @customer.auth_token + "/friends/new?iid=" + params[:customer][:codes_attributes]['0'][:incentive_id].to_s + "&redirect_uri=http://credvine.com/thanks"  }
            else #2 if not found, create new code
              new_code = Code.new()
              # push the partials codes WITHOUT friend partial
              new_code.cust_partial = @customer.partial_code
              new_code.smb_partial = @selector.partial_code
              # then push the complete codes WITHOUT friend complete code
              new_code.cust_success_code = new_code.smb_partial+new_code.cust_partial+random_partial
              new_code.cust_init_code = new_code.smb_partial+new_code.cust_partial
              #IMPORTANT: friend code has not been sent yet!
              new_code.frien_status = "NOT SENT"
              new_code.save(:validate => false)
              # Then create links without friend
              @selector.codes.push(new_code)
              @customer.codes.push(new_code)
              @active_campaign.codes.push(new_code)
              # push new code to incentives, to be tested.
              if params[:customer][:codes_attributes]['0'][:incentive_id].present?
                @selected_incentive = @active_campaign.incentives.find(params[:customer][:codes_attributes]['0'][:incentive_id])
                @selected_incentive.codes.push(new_code)
              end
              format.html { redirect_to "http://www.facebook.com/dialog/send?app_id=327499717302273&name=I found something I think you\'ll love. Check out " + @selector.full_name + "&link=http://credvine.com/smbs/#{@selector.auth_token}/customers/#{@customer.auth_token}/friends/new?cid=#{new_code.identifier}&picture=http://credvine.com/credvine_logo.png&description=I'm sending along a voucher with a special perk for your first visit - get it here: \n http://credvine.com/smbs/" + @selector.auth_token + "/customers/" + @customer.auth_token + "/friends/new?cid=" + new_code.identifier + "&redirect_uri=http://credvine.com/thanks?user=" + @selector.username }
              #format.mobile { redirect_to "http://www.facebook.com/dialog/send?app_id=327499717302273&name=Hey! Check out " + @selector.full_name + "&link=http://credvine.com&description=Go to this link to get your coupon!\n http://credvine.com/smbs/" + @selector.auth_token + "/customers/" + @customer.auth_token + "/friends/new?cid=" + new_code.identifier + "&redirect_uri=http://credvine.com/thanks"  }
            end
            # Then send the cust_init email to customer (sent param is always false)
            # TODO do something to limit emailing cust_init to 4 times a day at most.
            #if @selector.cust_init_coupon_request_times <= @selector.cust_init_coupon_redemption_times
              #email will only be sent after 6 hours of previous sending. TODO --> done
            #if (Time.parse(DateTime.now.to_s) - Time.parse(@customer.cust_init_sent_at.to_s))/3600 > 6 # meaning limiting to 4 times a day
            @customer.cust_init_coupon_request_times += 1
            UserMailer.cust_init(new_code, @selector, @customer, nil, @active_campaign, false).deliver
            @customer.cust_init_sent_at = Time.now
            @customer.save!
            #end
            #end
            
          else
            flash[:error] = "Something wrong. Please resend."
            format.html { redirect_to "/#{@selector.username}" }
            #format.mobile { redirect_to "/#{@selector.username}?mobile=1" }
            #format.json { render :json => @customer.errors, :status => :unprocessable_entity }
          end
        end
      end
    else
      respond_to do |format|
        flash[:error] = "There is no active campaign"
        format.html { redirect_to "/#{@selector.username}" }
        #format.mobile { redirect_to "/#{@selector.username}?mobile=1" }
      end
    end
  end
   
  
  # PUT /customers/1
  # PUT /customers/1.json
  def update  # it is impossible for a customer to update a referral, so no need to modify.
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to [@selector, @customer], :notice => 'Customer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    if params[:smb_id].present?
      @customers = @selector.customers
      @customer = @customers.find(params[:id])
      @customers.delete(@customer)
    elsif params[:friend_id].present?
      #prohibited from destroying
    else
      @customer = Customer.find(params[:id])
      @customer.destroy
    end


    respond_to do |format|
      if params[:smb_id].present?
        format.html { redirect_to smb_customers_path(@selector)}
      elsif params[:friend_id].present?
        format.html { redirect_to friend_customers_path(@selector)}
      else
        format.html { redirect_to customers_path}
      end
      format.json { head :ok }
    end
  end
  
  def uploadFile
    
    respond_to do |format|
      if DataFile.get_size(params[:upload]) < 5*1024*1024
        path = DataFile.save(params[:upload], params[:smb_id])
        @selector.create_data_file(:file_path => path)
        format.html {redirect_to review_smb_customers_path(@selector), :notice => "File has been uploaded successfully"}
        format.json { render :json => review_smb_customers_path(@selector), :status => :created, :location => review_smb_customers_path(@selector)}
      else

        format.html {redirect_to review_smb_customers_path(@selector), :notice => 'File is too large'}
        format.json { render :json => @selector.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def review
    @data = @selector.data_file
    if @data.present?
      @temps = @data.temp_table_for_custs
      pathname = @data.file_path
      oo = Excelx.new(pathname)
      oo.default_sheet = oo.sheets.first
      oo.first_row.upto(oo.last_row) do |line|
        fullname = oo.cell(line, 'A')
        phone = oo.cell(line, 'B')
        email = oo.cell(line, 'C')
        @temps.create(:fullname => fullname, :phone => phone, :email => email)
      end
      # delete the file
      File.delete(pathname)
      @customers = Array.new(oo.last_row - oo.first_row + 1){Customer.new}
    else
      @customers = Array.new(3){Customer.new}
    end
  end
  
  def confirm
    value1 = params[:table1][:fieldname1]
    value2 = params[:table2][:fieldname2]
    value3 = params[:table3][:fieldname3]
    
     if ((value1 != value2) and (value2 != value3) and (value1 != value3))
       #the following line might have more hashes in new(), because more information may be needed to be stored into db.
       @customers_unfiltered = params["customers"].values.collect {|customer| @selector.customers.new(:fullname => customer[value1], :phone => customer[value2], :email => customer[value3], :partial_code => SecureRandom.base64(5).delete("=").delete("\n\r").tr("+/", "-_"), :auth_token => SecureRandom.base64.delete("=").delete("\n\r").tr("+/", "-_"))}
       # here to do the filter work: filter out the customers which have already been in the db.
       @customers = []
       @num_of_custs_uploaded = 0
       @customers_unfiltered.each do |customer|
         if !@selector.customers.find_by_email(customer.email)
           @customers.push(customer)
           @num_of_custs_uploaded += 1
         end
       end
       respond_to do |format|
         if (@customers && @customers.all?(&:valid?))
           @customers.each(&:save!)
           # hook to current smb
           @customers.each do |customer|
             @selector.customers.push(customer)
           end   
           format.html {redirect_to smb_customers_path(@selector), :notice => "Customers list has been imported successfully: "+@customers_unfiltered.count.to_s+" uploaded, "+@num_of_custs_uploaded.to_s+" saved, "+(@customers_unfiltered.count-@num_of_custs_uploaded).to_s+" already existed."}
           format.json { render :json => smb_customers_path(@selector), :status => :created, :location => smb_customers_path(@selector)}
         else
           format.html { render :action => "review"}
           @customers.each do |customer|
             format.json { render :json => customer.errors, :status => :unprocessable_entity }
           end
         end
       end
     else
       respond_to do |format|
         format.html { redirect_to review_smb_customers_path(@selector), :error => "Error: You selected identical headings"}
         # @customers.each do |customer|
             # format.json { render :json => customer.errors, :status => :unprocessable_entity }
         # end
       end
     end
  end
  
  def send_message
  end
  
  
  def referral_sent
    @customer = @ref_form_selector.customers.find_by_auth_token(params[:id])
    respond_to do |format|
      format.html {render :layout => "mobile_application"}
    end
  end

end
