class AddCountryIdAndStateIdToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :country_id, :integer
    add_column :smbs, :state_id, :integer
  end
end
