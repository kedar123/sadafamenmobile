class Addprayerviewedandprayed < ActiveRecord::Migration
  def self.up
    add_column :prayers, :viewed_no, :integer    
    add_column :prayers, :prayed_no, :integer    
  end

  def self.down
    remove_column :prayers, :viewed_no
    remove_column :prayers, :prayed_no
  end
end

