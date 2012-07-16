class AddTempFinalThxToCodes < ActiveRecord::Migration
  def change
    add_column :codes, :temp_final_thx, :text

  end
end
