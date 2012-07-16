class FriendsController < ApplicationController
  # GET /friends
  # GET /friends.json  
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
  
  before_filter :get_cust_smb_path
  
  def get_cust_smb_path 
    if (params[:smb_id].present? and params[:customer_id].present?)
      @smb = Smb.find_by_auth_token(params[:smb_id])
      @selector = @smb.customers.find_by_auth_token(params[:customer_id])
      @smb_friends = @smb.friends   
      @cust_friends = Customer.find_by_auth_token(params[:customer_id]).friends
      @collection = find_conjunction(@smb_friends, @cust_friends, Friend)
    elsif params[:customer_id].present?
      @selector = Customer.find_by_auth_token(params[:customer_id])
    elsif params[:smb_id].present?
      if admin?
        @selector = Smb.find_by_auth_token(params[:smb_id])
      end
    end
  end
  
  def index
    if admin?
      if (params[:customer_id].present? and params[:smb_id].present?)
        @friends = @collection.uniq
      elsif (params[:customer_id].present? or params[:smb_id].present?)
        @friends = @selector.friends
      else
        @friends = Friend.all
      end
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @friends }
      end
    else
      flash[:error] = "Not Authorized"
      redirect_to root_url
    end
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    if admin?
      if (params[:customer_id].present? and params[:smb_id].present?)
        @friend = @collection.find(params[:id])
      elsif (params[:customer_id].present? or params[:smb_id].present?)
        @friend = @selector.friends.find(params[:id])
      else
        @friend = Friend.find(params[:id])
      end
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @friend }
      end
    else
      flash[:error] = "Not Authorized"
      redirect_to root_url
    end
  end

  # GET /friends/new
  # GET /friends/new.json
  def new
    @friend = Friend.new

    respond_to do |format|
      format.html {render :layout => "mobile_application"}# new.html.erb
      format.json { render :json => @friend}
    end
  end

  # GET /friends/1/edit
  def edit
    if admin?
      if (params[:customer_id].present? and params[:smb_id].present?)
        @friend = @collection.find(params[:id])
      elsif (params[:customer_id].present? or params[:smb_id].present?)
        @friend = @selector.friends.find(params[:id])
      else
        @friend = Friend.find(params[:id])
      end
    else
      flash[:error] = "Not Authorized"
      redirect_to root_url
    end
  end

  # POST /friends
  # POST /friends.json
  def create
    if active_campaign = @smb.campaigns.find_by_status(true)
      @active_campaign = active_campaign
    
      @email_of_friend = Friend.where(:email => params[:friend][:email])
      puts @email_of_friend
      if @email_of_friend.empty?
        @friend = Friend.new(params[:friend])
        @friend.partial_code = SecureRandom.base64(5).delete("=").delete("\n\r").tr("+/", "-_")
      else
        @friend = @email_of_friend.first
        @friend.attributes = {:fullname => params[:friend][:fullname]}
      end
      respond_to do |format|
        if @friend.save
          #@collection.push(@friend)
          # avoid friends from being pushed twice (diff smb, same cust and same frien scenario):
          if @smb.friends.where(:id => @friend.id).empty?
            @smb.friends.push(@friend)
          end
          if @selector.friends.where(:id => @friend.id).empty?
            @selector.friends.push(@friend)
          end
          
          if params[:cid].present?
            half_code = Code.find_by_identifier(params[:cid])
            @friend.codes.push(half_code)
            half_code.frien_partial = @friend.partial_code
            half_code.frien_code = half_code.smb_partial+half_code.cust_partial+half_code.frien_partial
            half_code.frien_status = "SENT"
            half_code.save!
            #TODO need customer's friend welcome/referral email text this time              
            UserMailer.frien_welc(half_code, half_code.incentive.frien_incentive, @smb, @selector, @friend, @active_campaign, false).deliver
          elsif params[:iid].present?
            codes = find_conjunction(@smb.codes, @selector.codes, Code)
            codes.each do |code| # meaning same smb, same cust, same frien !
              if code.frien_partial == @friend.partial_code
                @code = code
              end
            end
            #code = codes.find_by_frien_partial(@friend.partial_code) # meaning same smb, same cust, smb frien !
            if @code.present? #if there is a code whose frien_partial == @friend.partial_code
              # Because at this time, customer's init coupon has already been sent before.
              # if code.cust_init_status == "SENT"
                    # #update the status attribute to SENT_AGAIN
                    # code.update_attributes(:cust_init_status => "SENT_AGAIN")
                    # #send customer initial thank-you mail(in campaign creation) with init coupon code again.
                    # UserMailer.cust_init(code, @selector, @customer, @active_campaign, true).deliver
              # elsif code.cust_init_status == "REDEEMED"
                # #nothing sent
              # end
              if @code.frien_status == "SENT" #friend referral sent but not redeemed yet
                @code.update_attributes(:frien_status => "SENT_AGAIN")
                #need customer's friend welcome/referral email text this time 
                UserMailer.frien_welc(@code, @code.incentive.frien_incentive, @smb, @selector, @friend, @active_campaign, true).deliver
                # friend has not yet redeemed the code, so cust_success_status MUST BE SENT ONLY.
                # if code.cust_success_status == "NOT_SENT" #optional to write if here, because the status is bond to be NOT_SENT.
                  # #nothing sent
                # end
              elsif @code.frien_status == "REDEEMED"
                # Nothing Sent
                # SAME customer refers the SAME company to the SAME friend, so this customer's success email MUST HAVE ALREADY BEEN SENT.
                if @code.cust_success_status == "SENT"
                  @code.update_attributes(:cust_success_status => "SENT_AGAIN")
                  UserMailer.cust_success(@code.temp_final_thx, @code, @smb, @selector, @friend, @active_campaign, true).deliver
                elsif @code.cust_success_status == "REDEEMED"
                  UserMailer.cust_success_redeemed(@smb, @selector, @friend, @active_campaign, true).deliver
                end
              end
            else # code == nil, meaning same smb, same cust, diff frien
              # create new code
              random_partial = SecureRandom.base64(5).delete("=").delete("\n\r").tr("+/", "-_")
              @code = Code.new()
              @code.frien_partial = @friend.partial_code
              @code.cust_partial = @selector.partial_code
              @code.smb_partial = @smb.partial_code
              @code.cust_success_code = @code.smb_partial+@code.cust_partial+random_partial
              @code.frien_code = @code.smb_partial+@code.cust_partial+@code.frien_partial
              @code.cust_init_code = @code.smb_partial+@code.cust_partial
              @code.save(:validate => false)
              
              @smb.codes.push(@code)
              @selector.codes.push(@code)
              @friend.codes.push(@code)
              @active_campaign.codes.push(@code)
              
              @selected_incentive = @active_campaign.incentives.find(params[:iid])
              @selected_incentive.codes.push(@code)
              
              UserMailer.frien_welc(@code, @code.incentive.frien_incentive, @smb, @selector, @friend, @active_campaign, false).deliver
              @code.frien_status = "SENT"
              @code.save!
            end
          else
            # not legal, but do nothing.
          end
            
          format.html { redirect_to confirmed_smb_customer_friend_path(@smb, @selector, @friend) } #TODO change to some congratulation page
          format.json { render :json => confirmed_smb_customer_friend_path(@smb, @selector, @friend), :status => :created, :location => confirmed_smb_customer_friend_path(@smb, @selector, @friend)}
        else
          format.html { render :action => "new" }
          format.json { render :json => @friend.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to error_smb_customer_friends_path(@smb, @selector)
    end
  end

  # PUT /friends/1
  # PUT /friends/1.json
  # no point to update a friend.
  def update
    @friend = Friend.find(params[:id])

    respond_to do |format|
      if @friend.update_attributes(params[:friend])
        format.html { redirect_to [@smb, @selector, @friend], :notice => 'Friend was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    if (params[:customer_id].present? and params[:smb_id].present?)
      @collection.delete(@friend)
    elsif (params[:smb_id].present? or params[:customer_id].present?)
    else
      @friend = Friend.find(params[:id])
      @friend.destroy
    end

    respond_to do |format|
      if (params[:customer_id].present? and params[:smb_id].present?)
        format.html { redirect_to smb_customer_friends_path(@smb, @selector) }
      elsif (params[:smb_id].present? or params[:customer_id].present?)
      else
        format.html { redirect_to friends_path }
      end
      format.json { head :ok }
    end
  end
  
  def error
  end
  
  def confirmed
    @friend = @collection.find(params[:id])
    respond_to do |format|
      format.html {render :layout => "mobile_application"}
    end
  end
  
end
