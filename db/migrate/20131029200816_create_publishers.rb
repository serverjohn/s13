class CreatePublishers < ActiveRecord::Migration
  def self.up
    create_table :publishers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :publishers
  end
end
