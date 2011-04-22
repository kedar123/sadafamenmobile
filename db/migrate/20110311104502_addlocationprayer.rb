class Addlocationprayer < ActiveRecord::Migration
  def self.up
     add_column :prayers, :location, :string
     add_column :prayers, :title, :string
     add_column :prayers, :description, :string
  end

  def self.down
     remove_column :prayers, :location
     remove_column :prayers, :title
     remove_column :prayers, :description
  end
end
