class AddIdentifierToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :identifier, :string

  end
end
