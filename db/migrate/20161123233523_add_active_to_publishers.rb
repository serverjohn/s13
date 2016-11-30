class AddActiveToPublishers < ActiveRecord::Migration
  def self.up
    add_column :publishers, :active, :string
  end
end
