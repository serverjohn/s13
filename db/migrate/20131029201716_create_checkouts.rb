class CreateCheckouts < ActiveRecord::Migration
  def self.up
    create_table :checkouts do |t|
      t.integer :user_id
      t.integer :terriory_id
      t.integer :publisher_id
      t.string :checked_out
      t.string :checked_in
      t.string :completed_with
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :checkouts
  end
end
