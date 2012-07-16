class AddActivatedToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :activated, :boolean

  end
end
