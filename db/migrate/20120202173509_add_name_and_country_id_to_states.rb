class AddNameAndCountryIdToStates < ActiveRecord::Migration
  def change
    add_column :states, :name, :string
    add_column :states, :country_id, :integer
  end
end
