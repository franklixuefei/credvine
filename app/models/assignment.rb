class Assignment < ActiveRecord::Base
  belongs_to :customer
  belongs_to :friend
end
