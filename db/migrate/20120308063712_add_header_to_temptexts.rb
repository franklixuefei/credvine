class AddHeaderToTemptexts < ActiveRecord::Migration
  def change
    add_column :temptexts, :header_message, :text

  end
end
