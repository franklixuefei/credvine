class CodePointer < ActiveRecord::Base
  has_many :codes
  before_save :create_identifier
  
  def create_identifier
    begin
      temp_identifier = SecureRandom.base64.delete("=").delete("\n\r").tr("+/", "-_")
      self.identifier = temp_identifier
    end while CodePointer.exists?(:identifier => temp_identifier)
  end
end
