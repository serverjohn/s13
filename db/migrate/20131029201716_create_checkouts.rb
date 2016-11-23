class CreateCheckouts < ActiveRecord::Migration
  def self.up
    create_table :checkouts do |t|
      t.integer :user_id
      t.integer :territory_id
      t.integer :publisher_id
      t.integer :territory_type_id
      t.integer :worked_with_type_id
      t.datetime :checked_out
      t.datetime :checked_in
      t.string :completed_with
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :checkouts
  end
end
