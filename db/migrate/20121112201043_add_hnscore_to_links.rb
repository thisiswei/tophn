class AddHnscoreToLinks < ActiveRecord::Migration
  def change 
    add_column :links, :hnscore, :integer
  end
end
