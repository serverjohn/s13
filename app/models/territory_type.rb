class TerritoryType < ActiveRecord::Base
  has_many :territories
  has_many :checkouts
  
  validates_presence_of :name
end
