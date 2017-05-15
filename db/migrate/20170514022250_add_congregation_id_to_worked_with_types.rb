class AddCongregationIdToWorkedWithTypes < ActiveRecord::Migration
  def change
    add_column :worked_with_types, :congregation_id, :integer
  end
end
