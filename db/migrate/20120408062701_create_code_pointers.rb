class CreateCodePointers < ActiveRecord::Migration
  def change
    create_table :code_pointers do |t|

      t.timestamps
    end
  end
end
