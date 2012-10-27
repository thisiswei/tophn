class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    # t.string :email, :null => false, :default => ""
    #  t.string :username
      t.timestamps
    end
  end
end
