class AddStateProvToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :state_prov, :string
  end
end
