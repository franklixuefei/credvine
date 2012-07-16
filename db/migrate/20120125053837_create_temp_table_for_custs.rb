class CreateTempTableForCusts < ActiveRecord::Migration
  def change
    create_table :temp_table_for_custs do |t|
      t.string :fullname
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
