class Publisher < ActiveRecord::Base
  has_many :checkouts
  
  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :first_name, :scope => :last_name
  

  
  def name
    "#{last_name}, #{first_name}"
  end
end
