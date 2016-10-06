class WorkedWithType < ActiveRecord::Base
  has_many :checked_outs
  
  validates_presence_of :name
end
