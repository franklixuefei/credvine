class CreateIncentiveTypeFis < ActiveRecord::Migration
  def change
    create_table :incentive_type_fis do |t|
      t.string :type_of_incentive

      t.timestamps
    end
  end
end
