class AddHnscoreToLinks < ActiveRecord::Migration
  def change
    add_column :links, :hnscore, :integer, :default => 0
  end
end
