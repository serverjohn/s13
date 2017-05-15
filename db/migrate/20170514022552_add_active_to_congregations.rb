class AddActiveToCongregations < ActiveRecord::Migration
  def change
    add_column :congregations, :active, :string
  end
end
