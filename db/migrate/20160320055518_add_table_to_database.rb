class AddTableToDatabase < ActiveRecord::Migration
  def self.up
    create_table :worked_with_types do |t|
      t.column :name, :string, :null => false
      t.column :active, :string, :null => false
    end
  end

  def self.down
  end
end
