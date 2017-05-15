class AddCongregationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :congregation_id, :integer
  end
end
