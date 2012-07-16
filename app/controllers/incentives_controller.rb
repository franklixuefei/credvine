class IncentivesController < ApplicationController
  # GET /incentives
  # GET /incentives.json
  before_filter :get_selector
  
  def get_selector
    if (params[:smb_id].present? and params[:campaign_id].present?)
      if current_user
        @smb = current_user
        @campaigns = @smb.campaigns
        @selector = @campaigns.find(params[:campaign_id])
      end
    elsif params[:campaign_id].present?
      @selector = Campaign.find(params[:campaign_id])
    end
  end
  
  def index
    if (params[:smb_id].present? or params[:campaign_id].present?)
      if current_user
        @incentives = @selector.incentives
        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @incentives }
        end
      else
        flash[:error] = "You must login first"
        redirect_to log_in_path
      end
    else
      if admin?
        @incentives = Incentive.all
        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @incentives }
        end
      end
    end


  end

  # GET /incentives/1
  # GET /incentives/1.json
  def show
    if (params[:smb_id].present? or params[:campaign_id].present?)
      if current_user
        @incentive = @selector.incentives.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render :json => @incentive }
        end
      else
        flash[:error] = "You must login first"
        redirect_to log_in_path
      end
    else
      if admin?
        @incentive = Incentive.find(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render :json => @incentive }
        end
      end
    end
  end

  # GET /incentives/new
  # GET /incentives/new.json
  def new
    if current_user
      @incentive = Incentive.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => [@campaign, @incentive] }
      end
    else
      flash[:error] = "You must login first"
      redirect_to log_in_path
    end
  end

  # GET /incentives/1/edit
  def edit
    if current_user
      @incentive = @selector.incentives.find(params[:id])
    else
      flash[:error] = "You must login first"
      redirect_to log_in_path
    end
  end

  # POST /incentives
  # POST /incentives.json
  def create
    @incentive = @selector.incentives.new(params[:incentive])

    respond_to do |format|
      if @incentive.save
        format.html { redirect_to [@smb, @selector, @incentive], :notice => 'Incentive was successfully created.' }
        format.json { render :json => [@smb, @selector, @incentive], :status => :created, :location => [@smb, @selector, @incentive] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @incentive.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /incentives/1
  # PUT /incentives/1.json
  def update
    @incentive = Incentive.find(params[:id])

    respond_to do |format|
      if @incentive.update_attributes(params[:incentive])
        format.html { redirect_to [@smb, @selector, @incentive], :notice => 'Incentive was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @incentive.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /incentives/1
  # DELETE /incentives/1.json
  def destroy
    @incentive = Incentive.find(params[:id])
    @incentive.destroy

    respond_to do |format|
      format.html { redirect_to smb_campaign_incentives_path(@smb, @selector) }
      format.json { head :ok }
    end
  end
end
