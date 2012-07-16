class AddPerSuccessToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :per_success, :boolean, :default => true
  end
end
