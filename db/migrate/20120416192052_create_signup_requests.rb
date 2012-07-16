class CreateSignupRequests < ActiveRecord::Migration
  def change
    create_table :signup_requests do |t|
      t.string :request_email
      t.string :package_type
      t.string :beta_key

      t.timestamps
    end
  end
end
