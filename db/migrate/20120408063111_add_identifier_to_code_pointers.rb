class AddIdentifierToCodePointers < ActiveRecord::Migration
  def change
    add_column :code_pointers, :identifier, :string

  end
end
