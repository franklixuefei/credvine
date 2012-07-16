class Code < ActiveRecord::Base
  belongs_to :smb
  belongs_to :customer
  belongs_to :friend
  belongs_to :campaign
  belongs_to :incentive
  belongs_to :code_pointer
  validates_presence_of :incentive_id
  
  before_create :create_identifier
  
  def create_identifier
    begin
      temp_identifier = SecureRandom.base64.delete("=").delete("\n\r").tr("+/", "-_")
      self.identifier = temp_identifier
    end while Code.exists?(:identifier => temp_identifier)
  end
end
