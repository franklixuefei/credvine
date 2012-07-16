class AddCardOnFileToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :card_on_file, :boolean, :default => false
  end
end
