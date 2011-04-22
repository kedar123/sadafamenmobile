class Addrejectedfriend < ActiveRecord::Migration
  def self.up
    add_column :friendships, :rejecter_id, :integer    
  end

  def self.down
    remove_column :friendships,:rejecter_id
  end
end
