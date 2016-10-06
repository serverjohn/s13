class AddPhoneNumberToPublishers < ActiveRecord::Migration
  def self.up
    add_column :publishers, :phone_number, :string
  end

  def self.down
    remove_column :publishers, :phone_number
  end
end
