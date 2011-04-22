class Addprayeridtocomment < ActiveRecord::Migration
  def self.up
     add_column :comments, :prayer_id, :integer
  end

  def self.down
     remove_column :comments, :prayer_id
  end
end
