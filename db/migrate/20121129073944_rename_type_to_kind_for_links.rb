class RenameTypeToKindForLinks < ActiveRecord::Migration
  def up
    rename_column :links, :type, :kind
  end


  def down
    rename_column :links, :kind , :type
  end
end
