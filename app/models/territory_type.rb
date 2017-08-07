class TerritoryType < ActiveRecord::Base
  has_many :territories
  has_many :checkouts
  belongs_to :congregation
  validates_presence_of :name, :congregation_id, :active
end
