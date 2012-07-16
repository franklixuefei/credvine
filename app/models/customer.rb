class Customer < ActiveRecord::Base
  attr_accessor :send_to_another
  has_and_belongs_to_many :smbs
  has_many :assignments
  has_many :friends, :through => :assignments
  has_many :codes
  accepts_nested_attributes_for :assignments
  accepts_nested_attributes_for :friends
  validates :fullname, :presence => true
  validates :email, :email_format => true
  #validates_uniqueness_of :email
  accepts_nested_attributes_for :codes
  
  def to_param
    auth_token
  end
end