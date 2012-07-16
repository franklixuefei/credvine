class AddFeaturedPhotoToSmbs < ActiveRecord::Migration
  def change
    add_column :smbs, :featured_photo_file_name, :string

    add_column :smbs, :featured_photo_content_type, :string

    add_column :smbs, :featured_photo_file_size, :integer

    add_column :smbs, :featured_photo_updated_at, :datetime

  end
end
