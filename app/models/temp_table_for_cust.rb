class TempTableForCust < ActiveRecord::Base
  belongs_to :data_file
end
