class CreateIncentiveTypes < ActiveRecord::Migration
  def change
    create_table :incentive_types do |t|
      t.string :type

      t.timestamps
    end
  end
end
