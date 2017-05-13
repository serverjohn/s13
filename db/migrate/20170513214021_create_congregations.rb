class CreateCongregations < ActiveRecord::Migration
  def change
    create_table :congregations do |t|
      t.string :name

      t.timestamps
    end
  end
end
