class CreateBusinessCatagories < ActiveRecord::Migration
  def change
    create_table :business_catagories do |t|

      t.timestamps
    end
  end
end
