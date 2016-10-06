class ReceivesTextMessagesToPublishers < ActiveRecord::Migration
  def self.up
    add_column :publishers, :textmessage, :string
  end

  def self.down
    remove_column :publishers, :textmessage
  end
end
