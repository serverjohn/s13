class DropPublishersTable < ActiveRecord::Migration
  def up
  	drop_table :publishers
  end

  def down
    create_table :publishers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :notes
      t.string :phone_number
      t.string :textmessage 
      t.string :active
      t.timestamps
    end
  end
end
