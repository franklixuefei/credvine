class AddCodePointerIdToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :code_pointer_id, :integer

  end
end
