class AddTypeToLinks < ActiveRecord::Migration
  def change
    add_column :links, :type , :string
    Link.all.each do |link|
      link.update_attributes(type:  link.hnscore > 80 ? 'top' : 'keyword' )
    end
  end
end
