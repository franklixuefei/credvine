class AddAttachmentLogoToSmb < ActiveRecord::Migration
  def self.up
    add_column :smbs, :logo_file_name, :string
    add_column :smbs, :logo_content_type, :string
    add_column :smbs, :logo_file_size, :integer
    add_column :smbs, :logo_updated_at, :datetime
  end

  def self.down
    remove_column :smbs, :logo_file_name
    remove_column :smbs, :logo_content_type
    remove_column :smbs, :logo_file_size
    remove_column :smbs, :logo_updated_at
  end
end
