class AddBusinessTypeToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :business_type, :string

  end
end
