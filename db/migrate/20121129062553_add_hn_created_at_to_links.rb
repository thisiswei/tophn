class AddHnCreatedAtToLinks < ActiveRecord::Migration
  def change
    add_column :links, :hn_created_at , :datetime
  end
end
