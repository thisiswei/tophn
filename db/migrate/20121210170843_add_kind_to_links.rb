class AddKindToLinks < ActiveRecord::Migration
  def change
      add_column :links, :kind , :string
      Link.all.each do |link|
        link.update_attributes(kind:  link.hnscore > 80 ? 'top' : 'keyword' )
      end  
  end
end
