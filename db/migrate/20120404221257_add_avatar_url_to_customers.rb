class AddAvatarUrlToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :avatar_url, :string

  end
end
