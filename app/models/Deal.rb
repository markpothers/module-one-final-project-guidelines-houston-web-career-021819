class Deal < ActiveRecord::Base

  belongs_to :city
  belongs_to :merchant
  belongs_to :service
 # has_many :cities
 # has_many :merchants
 # has_many :products

end 