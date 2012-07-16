class AddCreditToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :credit, :string

  end
end
