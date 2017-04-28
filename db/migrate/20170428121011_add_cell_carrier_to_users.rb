class AddCellCarrierToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cell_carrier, :string
  end
end
