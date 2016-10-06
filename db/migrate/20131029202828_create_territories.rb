class CreateTerritories < ActiveRecord::Migration
  def self.up
    create_table :territories do |t|
      t.string :type
      t.string :name
      t.string :description
      t.string :map
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :territories
  end
end
