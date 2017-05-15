class AddCongregationIdToTerritoryTypes < ActiveRecord::Migration
  def change
    add_column :territory_types, :congregation_id, :integer
  end
end
