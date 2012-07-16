class Campaign < ActiveRecord::Base
  belongs_to :smb
  belongs_to :incentive_type
  belongs_to :incentive_type_csi
  has_many :incentives, :dependent => :destroy
  has_many :codes
  #accepts_nested_attributes_for :incentives, :reject_if => lambda { |a| (a[:cust_sent_incentive].blank? and a[:cust_successful_incentive].blank? and a[:frien_incentive].blank?) }, :allow_destroy => true
  accepts_nested_attributes_for :incentives, :allow_destroy => true
  validates_presence_of :camp_name
  #validates_format_of :camp_name, :with => /^[-\w\._@]+$/i, :message => "should only contain letters, numbers, or .-_@"
  
  #validates :end_date, :date_range => true



end
