class AddTerritoryTypesTableToDatabase < ActiveRecord::Migration
  def self.up
    create_table :territory_types do |t|
      t.column :name, :string
      t.column :active, :string
      t.column :checkout_id, :int, :null => false
    end
  end

  def self.down
  end
end
