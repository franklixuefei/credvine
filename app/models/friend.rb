class Friend < ActiveRecord::Base
  has_many :assignments
  has_many :customers, :through => :assignments
  has_and_belongs_to_many :smbs
  has_many :codes
  validates :fullname, :presence => true
  validates :email, :email_format => true
end
