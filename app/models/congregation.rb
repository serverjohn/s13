class Congregation < ActiveRecord::Base
  has_many :checkouts
  has_many :users
  has_many :worked_with_types
  has_many :territory
  has_many :territory_types
  
  validates_presence_of :name, :active
end
