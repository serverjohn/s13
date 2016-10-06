class Checkout < ActiveRecord::Base
  belongs_to :user
  belongs_to :territory
  belongs_to :publisher
  belongs_to :territory_type
  belongs_to :worked_with_type
  
  validates_presence_of :user_id, :territory_id, :publisher_id, :checked_out
end
