class AddTerritoryTypesTypeIdToTerritories < ActiveRecord::Migration
  def self.up
    add_column :territories, :territory_type_id, :string
  end

  def self.down
    remove_column :territories, :territory_type_id
  end
end
