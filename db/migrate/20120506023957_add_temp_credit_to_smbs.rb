class AddTempCreditToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :temp_credit, :integer, :default => 0
  end
end
