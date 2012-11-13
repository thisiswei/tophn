class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :link_id
      t.integer :score, :default => 0 
      t.timestamps
    end
  end
end
