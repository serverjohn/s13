class Territory < ActiveRecord::Base
  belongs_to :territory_type
  belongs_to :congregation
  has_many :checkouts
  
  
  validates_presence_of :territory_type_id, :name, :active, :congregation_id, :active
  validates_uniqueness_of :name, :maps
end
