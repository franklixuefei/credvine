class CreateIncentiveTypeCsis < ActiveRecord::Migration
  def change
    create_table :incentive_type_csis do |t|
      t.string :type_of_incentive

      t.timestamps
    end
  end
end
