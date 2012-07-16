class UploadController < ApplicationController
  before_filter :get_smb
    
  def get_smb 
    @smb = Smb.find(params[:smb_id])
  end
  
  def index
    render :file => 'upload/uploadfile.rhtml'
  end

  def upload
    respond_to do |format|
      if DataFile.get_size(params[:upload]) < 5*1024*1024
        post = DataFile.save(params[:upload])
        format.html {redirect_to smb_customers_path(@smb), :notice => "File has been uploaded successfully"}
        format.json { render :json => @post, :status => :created, :location => @post}
      else

        format.html {redirect_to uploadFile_smb_customers_path(@smb), :error => 'File is too large'}
        format.json { render :json => DataFile.params[:upload], :status => :unprocessable_entity }
      end
    end
  end

end
