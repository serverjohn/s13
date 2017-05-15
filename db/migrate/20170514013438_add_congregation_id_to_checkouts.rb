class AddCongregationIdToCheckouts < ActiveRecord::Migration
  def change
    add_column :checkouts, :congregation_id, :integer
  end
end
