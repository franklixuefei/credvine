class AddBlablaToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :site_url, :string

    add_column :smbs, :facebook_url, :string

    add_column :smbs, :twitter_url, :string

    add_column :smbs, :yelp_url, :string

    add_column :smbs, :linkedin_url, :string

  end
end
