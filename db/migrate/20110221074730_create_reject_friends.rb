class CreateRejectFriends < ActiveRecord::Migration
  def self.up
    create_table :reject_friends do |t|
      t.string :rejected_email_id
      t.integer :user_id  
      t.timestamps
    end
  end

  def self.down
    drop_table :reject_friends
  end
end
