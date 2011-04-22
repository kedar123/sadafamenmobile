class CreateInvitationSents < ActiveRecord::Migration
  def self.up
    create_table :invitation_sents do |t|
      t.string :from_email
      t.string :to_email
      t.timestamps
    end
  end

  def self.down
    drop_table :invitation_sents
  end
end
