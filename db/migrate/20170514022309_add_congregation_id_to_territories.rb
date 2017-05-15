class AddCongregationIdToTerritories < ActiveRecord::Migration
  def change
    add_column :territories, :congregation_id, :integer
  end
end
