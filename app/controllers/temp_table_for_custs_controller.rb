class TempTableForCustsController < ApplicationController
  # GET /temp_table_for_custs
  # GET /temp_table_for_custs.json
  def index
    @temp_table_for_custs = TempTableForCust.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @temp_table_for_custs }
    end
  end

  # GET /temp_table_for_custs/1
  # GET /temp_table_for_custs/1.json
  def show
    @temp_table_for_cust = TempTableForCust.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @temp_table_for_cust }
    end
  end

  # GET /temp_table_for_custs/new
  # GET /temp_table_for_custs/new.json
  def new
    @temp_table_for_cust = TempTableForCust.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @temp_table_for_cust }
    end
  end

  # GET /temp_table_for_custs/1/edit
  def edit
    @temp_table_for_cust = TempTableForCust.find(params[:id])
  end

  # POST /temp_table_for_custs
  # POST /temp_table_for_custs.json
  def create
    @temp_table_for_cust = TempTableForCust.new(params[:temp_table_for_cust])

    respond_to do |format|
      if @temp_table_for_cust.save
        format.html { redirect_to @temp_table_for_cust, :notice => 'Temp table for cust was successfully created.' }
        format.json { render :json => @temp_table_for_cust, :status => :created, :location => @temp_table_for_cust }
      else
        format.html { render :action => "new" }
        format.json { render :json => @temp_table_for_cust.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /temp_table_for_custs/1
  # PUT /temp_table_for_custs/1.json
  def update
    @temp_table_for_cust = TempTableForCust.find(params[:id])

    respond_to do |format|
      if @temp_table_for_cust.update_attributes(params[:temp_table_for_cust])
        format.html { redirect_to @temp_table_for_cust, :notice => 'Temp table for cust was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @temp_table_for_cust.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_table_for_custs/1
  # DELETE /temp_table_for_custs/1.json
  def destroy
    @temp_table_for_cust = TempTableForCust.find(params[:id])
    @temp_table_for_cust.destroy

    respond_to do |format|
      format.html { redirect_to temp_table_for_custs_url }
      format.json { head :ok }
    end
  end
end
