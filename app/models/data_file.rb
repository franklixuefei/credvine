
class DataFile < ActiveRecord::Base
  belongs_to :smb
  has_many :temp_table_for_custs
  
  def self.get_size(upload)
    upload['datafile'].size
  end
  
  def self.save(upload, smb_id)
    name =  upload['datafile'].original_filename
    `mkdir public/data/#{smb_id} 2>/dev/null`
    directory = "public/data/#{smb_id}"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
    return path
  end
  

end
