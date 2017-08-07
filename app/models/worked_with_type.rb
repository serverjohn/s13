class WorkedWithType < ActiveRecord::Base
  has_many :checkedouts
  belongs_to :congregation
  
  validates_presence_of :name, :congregation_id, :active
end
