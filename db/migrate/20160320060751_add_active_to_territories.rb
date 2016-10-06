class AddActiveToTerritories < ActiveRecord::Migration
  def self.up
    add_column :territories, :active, :string
  end

  def self.down
    remove_column :territories, :active
  end
end
