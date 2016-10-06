class Territory < ActiveRecord::Base
  belongs_to :territory_types
  has_many :checkouts
  
  validates_presence_of :type, :name, :active
  validates_uniqueness_of :name, :map
end
