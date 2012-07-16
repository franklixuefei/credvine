class CreateSmbs < ActiveRecord::Migration
  def change
    create_table :smbs do |t|
      t.string :full_name
      t.string :abbr_name
      t.string :catagory
      t.string :industry
      t.string :st_name_num
      t.integer :suite_num
      t.string :city
      t.string :state_prov
      t.string :zip_pos
      t.string :country
      t.string :email
      t.string :phone
      t.string :logo_name
      t.string :photo_name

      t.timestamps
    end
  end
end
