class Addimagefieldtouser < ActiveRecord::Migration
  def self.up
   add_column :users, :description, :string
   add_column :users, :content_type, :string 
   add_column :users, :filename, :string 
   add_column :users, :binary_data, :binary    
  end

  def self.down
   remove_column :users, :description
   remove_column :users, :content_type
   remove_column :users, :filename
   remove_column :users, :binary_data
  end
end
