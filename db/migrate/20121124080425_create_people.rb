class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :hn_username
      t.text   :about, limit: nil
      t.boolean :alpha_geek, :default => false
    end
  end
end
