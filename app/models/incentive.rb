class Incentive < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :incentive_type_fi
  has_many :codes
#  validates_uniqueness_of :frien_incentive, :scope => :campaign_id
#  validates_length_of :frien_incentive, :minimum => 5
end
