class AddPartialCodeToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :partial_code, :string
  end
end
