class IncentiveType < ActiveRecord::Base
  # since 2 types of customer incentives are in the incentives table now, so just copy everything related to the 2 types of customer
  # incentives from incentives table to campaigns table
  has_many :campaigns
end
