class AddHasBelongsToManyCheckout < ActiveRecord::Migration
  def self.up
    create_table :checkouts_publishers, :id => false do |t|
      t.integer :checkout_id
      t.integer :publisher_id

      t.timestamps
    end
  end

  def self.down
    drop_table :checkouts_publishers
  end
end
