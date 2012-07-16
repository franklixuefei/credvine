class CampaignsController < ApplicationController
  # GET /campaigns
  # GET /campaigns.json
  
  before_filter :get_smb
  
  def get_smb
    if params[:smb_id].present?
      if current_user
        @smb = current_user
      end
    end
  end
  
  
  
  def index
    if params[:smb_id].present?
      if current_user
        @campaigns = @smb.campaigns
        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @campaigns }
        end
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path
      end
    else
      if admin?
        @campaigns = Campaign.all
        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @campaigns }
        end
      end
    end
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    if params[:smb_id].present?
      if current_user
        @campaign = @smb.campaigns.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render :json => @campaign }
        end
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path
      end
    else
      if admin?
        @campaign = Campaign.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render :json => @campaign }
        end
      end
    end
  end

  # GET /campaigns/new
  # GET /campaigns/new.json
  def new
    if current_user
      @campaign = Campaign.new
      3.times {@campaign.incentives.build}
      respond_to do |format|
        format.html {}# new.html.erb
        #format.json { render :json => [@smb, @campaign]}
      end
    else
      flash[:error] = "You must login first!"
      redirect_to log_in_path and return
    end
    render :layout => "campaigns_layout"    
  end

  # GET /campaigns/1/edit
  def edit
    
    if params[:smb_id].present?
      if current_user
        3.times {@campaign.incentives.build}
        @campaign = @smb.campaigns.find(params[:id])
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path and return
      end
    else
      if admin?
        @campaign = Campaign.find(params[:id])
      end
    end
    render :layout => "campaigns_layout"
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    # if @smb.card_provided?
      # if @smb.campaign_confirmed
        #if all blank, then reject to save
        if params["campaign"]["incentive_attributes"].present? 
          params["campaign"]["incentives_attributes"].each_pair do |key, value|
              if (value["frien_incentive"].blank? and value["frien_incentive_long"].blank? and value["term_of_use_fi"].blank?)
                value[:_destroy] = "true"  
              end
          end
        end
        # @smb.campaigns.each do |campaign|
          # campaign.update_attributes(:status => false)
        # end
        # only work for ruby 1.9.x
        @campaign = @smb.campaigns.new(params[:campaign])
        @campaign.temp = false
        begin
          @campaign.start_date = Date.strptime(params[:campaign][:start_date], "%m/%d/%Y").strftime("%d/%m/%Y") if params[:campaign][:start_date]
        rescue ArgumentError
          @campaign.start_date = Date.strptime(params[:campaign][:start_date], "%Y-%m-%d").strftime("%d/%m/%Y") if params[:campaign][:start_date]
        end
        begin
          @campaign.end_date = Date.strptime(params[:campaign][:end_date], "%m/%d/%Y").strftime("%d/%m/%Y") if params[:campaign][:end_date]
        rescue ArgumentError
          @campaign.end_date = Date.strptime(params[:campaign][:end_date], "%Y-%m-%d").strftime("%d/%m/%Y") if params[:campaign][:end_date]
        end
        begin
          @campaign.exp_date = Date.strptime(params[:campaign][:exp_date], "%m/%d/%Y").strftime("%d/%m/%Y") if params[:campaign][:exp_date]
        rescue ArgumentError
          @campaign.exp_date = Date.strptime(params[:campaign][:exp_date], "%Y-%m-%d").strftime("%d/%m/%Y") if params[:campaign][:exp_date]
        end
        respond_to do |format|
          if @campaign.save
             @smb.campaigns.find(:all, :conditions => ['temp = ?', true]).each do |c|
              c.delete #TODO maybe destroy?
            end
            @smb.campaign_confirmed = false
            #if @smb.first_time
              @smb.campaign_activated = true
              format.html { redirect_to campaign_preview_smb_campaign_path(@smb, @campaign, :page => 1)}
              format.json { render :json => campaign_preview_smb_campaign_path(@smb, @campaign), :status => :created, :location => campaign_preview_smb_campaign_path(@smb, @campaign)}
            #else
              #format.html {
               # flash[:notice] = "Campaign successfully created!" 
                #redirect_to smb_campaign_path(@smb)
              #}
              #format.json { render :json => done_smb_path(@smb), :status => :created, :location => done_smb_path(@smb)}
           # end
            @smb.save!
          else
            format.html {
              flash[:error] = "Please check your campaign fields"
              render :action => "index" 
            }
            format.json { render :json => @campaign.errors, :status => :unprocessable_entity }
          end
        end
      # end
    # end
  end

  # PUT /campaigns/1
  # PUT /campaigns/1.json
  def update
    @campaign = Campaign.find(params[:id])
    if params["campaign"]["incentive_attributes"].present? 
      params["campaign"]["incentives_attributes"].each_pair do |key, value|
          if (value["frien_incentive"].blank? and value["frien_incentive_long"].blank? and value["term_of_use_fi"].blank?)
            value[:_destroy] = "true"  
          end
      end
    end
    begin
      params[:campaign][:start_date] = Date.strptime(params[:campaign][:start_date], "%Y-%m-%d").strftime("%d/%m/%Y") if params[:campaign][:start_date]
    rescue ArgumentError
      params[:campaign][:start_date] = Date.strptime(params[:campaign][:start_date], "%m/%d/%Y").strftime("%d/%m/%Y") if params[:campaign][:start_date]
    end
    begin
      params[:campaign][:end_date] = Date.strptime(params[:campaign][:end_date], "%Y-%m-%d").strftime("%d/%m/%Y") if params[:campaign][:end_date]
    rescue ArgumentError
      params[:campaign][:end_date] = Date.strptime(params[:campaign][:end_date], "%m/%d/%Y").strftime("%d/%m/%Y") if params[:campaign][:end_date]
    end
    begin
      params[:campaign][:exp_date] = Date.strptime(params[:campaign][:exp_date], "%Y-%m-%d").strftime("%d/%m/%Y") if params[:campaign][:exp_date]
    rescue ArgumentError
      params[:campaign][:exp_date] = Date.strptime(params[:campaign][:exp_date], "%m/%d/%Y").strftime("%d/%m/%Y") if params[:campaign][:exp_date]
    end
    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        format.html {
          if params[:page]
            flash[:notice] = "Campaign was successfully updated!"
            redirect_to campaign_preview_smb_campaign_path(@smb, @campaign, :page => params[:page])            
          else
            redirect_to smb_campaigns_path(@smb, :tab => @campaign.id), :notice => 'Campaign was successfully updated.'
          end
        }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy

    render json: ActiveSupport::JSON.encode({'ok' => 'true'})
  end
  
  def edit_status
    if params[:smb_id].present?
      if current_user
        @campaigns = @smb.campaigns.find(:all, :conditions => ['temp = ?', false])
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path
      end
    else
      if admin?
        @campaigns = Campaign.find(:all)
      end
    end
  end
  
  def update_status
    Campaign.update(params[:campaign].keys, params[:campaign].values)
    Campaign.all.each { |campaign| campaign.save(:validate => false) }
    flash[:notice] = 'Status were successfully updated.'
    redirect_to :action => "index"
  end
  
  def autosave
    @campaign = Campaign.find(params[:id])
    if params["campaign"]["incentive_attributes"].present? 
      params["campaign"]["incentives_attributes"].each_pair do |key, value|
          if (value["frien_incentive"].blank? and value["frien_incentive_long"].blank? and value["term_of_use_fi"].blank?)
            value[:_destroy] = "true"  
          end
      end
    end
    begin
      params[:campaign][:start_date] = Date.strptime(params[:campaign][:start_date], "%m/%d/%Y").strftime("%d/%m/%Y") if params[:campaign][:start_date]
    rescue
      begin
        params[:campaign][:start_date] = Date.strptime(params[:campaign][:start_date], "%Y-%m-%d").strftime("%d/%m/%Y") if params[:campaign][:start_date]
      rescue
        params[:campaign][:start_date] = nil
      end
    end
    begin
      params[:campaign][:end_date] = Date.strptime(params[:campaign][:end_date], "%m/%d/%Y").strftime("%d/%m/%Y") if params[:campaign][:end_date]
    rescue
      begin
        params[:campaign][:end_date] = Date.strptime(params[:campaign][:end_date], "%Y-%m-%d").strftime("%d/%m/%Y") if params[:campaign][:end_date]
      rescue
        params[:campaign][:end_date] = nil
      end
    end
    begin
      params[:campaign][:exp_date] = Date.strptime(params[:campaign][:exp_date], "%m/%d/%Y").strftime("%d/%m/%Y") if params[:campaign][:exp_date]
    rescue
      begin
        params[:campaign][:exp_date] = Date.strptime(params[:campaign][:exp_date], "%Y-%m-%d").strftime("%d/%m/%Y") if params[:campaign][:exp_date]
      rescue
        params[:campaign][:exp_date] = nil
      end
    end
#     
      # if @campaign.incentives.count == 0
        # incentive = @campaign.incentives.new()
      # else
        # incentive = @campaign.incentives.first
      # end
      # incentive.attributes = (params[:campaign][:incentives_attributes][0])
      # incentive.save!
#     
    #params[:campaign][:incentives_attributes] = incentive.to_a
    
    #params[:campaign].delete :incentives_attributes
    @campaign.incentives.destroy_all
    @campaign.attributes = (params[:campaign])
    @campaign.status = false
    
    if @campaign.save(:validate => false)
      render json: ActiveSupport::JSON.encode({ :ok => true, :test => @campaign.incentives.count })
    else
      render json: ActiveSupport::JSON.encode({ :ok => false })
    end
  end
  
  def autosave_create
    @campaign = @smb.campaigns.find(:all, :conditions => ['temp = ?', true], :limit => 1).first
    if @campaign
      render json: @campaign.to_json({:include => :incentives})
    else #no campaign found, make one
       #@smb.campaigns.find(:all, :conditions => ['temp = ?', true]).each do |c|
        # c.delete
      # end
      @campaign = @smb.campaigns.new()
      @campaign.save(:validate => false)
      render json: ActiveSupport::JSON.encode({:id => @campaign.id })
    end
  end
  
  
  def confirm_campaign
    if params[:smb_id].present?
      if current_user
        @campaign = @smb.campaigns.find(params[:camp_id])
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path
      end
    else
      if admin?
        @campaign = Campaign.find(params[:camp_id])
      end
    end
  end
  
  # def launch_campagin
#     
  # end
  
  def campaign_preview
    if params[:smb_id].present?
      if current_user
        if current_user.campaign_activated
          @campaign = @smb.campaigns.find(params[:id])
        else
          flash[:error] = "You must first create your campaign"
          redirect_to smb_campaigns_path(current_user)
        end
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path
      end
    else
      if admin?
        @campaign = Campaign.find(params[:id])
      end
    end
  end
  
  def campaign_launched
    if params[:smb_id].present?
      if current_user
        if current_user.campaign_launched
          @campaign = @smb.campaigns.find(params[:id])
          @smb.first_time = false
          @smb.save!
        else
          flash[:error] = "You must first preview your campaign"
          redirect_to campaign_preview_smb_campaign_path(current_user, @smb.campaigns.find(params[:id]))
        end
      else
        flash[:error] = "You must login first!"
        redirect_to log_in_path        
      end
    else
      if admin?
        @campaign = Campaign.find(params[:id])
      end
    end
  end
end
