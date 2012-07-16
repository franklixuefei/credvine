class SignupRequest < ActiveRecord::Base
  has_many :promo_codes
end
