class AddCheckinUserIdToCheckouts < ActiveRecord::Migration
  def self.up
    add_column :checkouts, :checkin_user_id, :integer
  end

  def self.down
    remove_column :checkouts, :checkin_user_id
  end
end
