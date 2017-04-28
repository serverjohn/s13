class AddTextMessageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :text_message, :string
  end
end
