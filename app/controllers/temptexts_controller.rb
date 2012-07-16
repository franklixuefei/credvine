class TemptextsController < ApplicationController
  # GET /temptexts
  # GET /temptexts.json
  def index
    @temptexts = Temptext.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @temptexts }
    end
  end

  # GET /temptexts/1
  # GET /temptexts/1.json
  def show
    @temptext = Temptext.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @temptext }
    end
  end

  # GET /temptexts/new
  # GET /temptexts/new.json
  def new
    @temptext = Temptext.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @temptext }
    end
  end

  # GET /temptexts/1/edit
  def edit
    @temptext = Temptext.find(params[:id])
  end

  # POST /temptexts
  # POST /temptexts.json
  def create
    @temptext = Temptext.new(params[:temptext])

    respond_to do |format|
      if @temptext.save
        format.html { redirect_to @temptext, :notice => 'Temptext was successfully created.' }
        format.json { render :json => @temptext, :status => :created, :location => @temptext }
      else
        format.html { render :action => "new" }
        format.json { render :json => @temptext.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /temptexts/1
  # PUT /temptexts/1.json
  def update
    @temptext = Temptext.find(params[:id])

    respond_to do |format|
      if @temptext.update_attributes(params[:temptext])
        format.html { redirect_to @temptext, :notice => 'Temptext was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @temptext.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /temptexts/1
  # DELETE /temptexts/1.json
  def destroy
    @temptext = Temptext.find(params[:id])
    @temptext.destroy

    respond_to do |format|
      format.html { redirect_to temptexts_url }
      format.json { head :ok }
    end
  end
end
