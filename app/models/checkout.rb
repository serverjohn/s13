class Checkout < ActiveRecord::Base
  belongs_to :user
  belongs_to :territory
  belongs_to :publisher
  belongs_to :territory_type
  belongs_to :worked_with_type
  belongs_to :congregation
  
  validates_presence_of :user_id, :territory_id, :checked_out, :congregation_id
end
