class AddHnuserToLinks < ActiveRecord::Migration
  def change
    add_column :links, :hnuser, :string
  end
end
