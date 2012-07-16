class CreatePointers < ActiveRecord::Migration
  def change
    create_table :pointers do |t|

      t.timestamps
    end
  end
end
