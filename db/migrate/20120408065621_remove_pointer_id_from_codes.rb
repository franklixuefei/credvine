class RemovePointerIdFromCodes < ActiveRecord::Migration
  def up
    remove_column :codes, :pointer_id
      end

  def down
    add_column :codes, :pointer_id, :integer
  end
end
