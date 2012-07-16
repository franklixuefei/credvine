class AddIidToCodePointers < ActiveRecord::Migration
  def change
    add_column :code_pointers, :iid, :integer

  end
end
