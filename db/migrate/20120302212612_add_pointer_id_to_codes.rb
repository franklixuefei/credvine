class AddPointerIdToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :pointer_id, :integer
  end
end
