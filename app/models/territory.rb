class Territory < ActiveRecord::Base
  belongs_to :territory_types
  has_many :checkouts
  
  validates_presence_of :territory_type_id, :name, :active, :maps
  validates_uniqueness_of :name, :maps
end
