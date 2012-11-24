class AddPersonIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :person_id, :integer
  end
end
