class Product < ActiveRecord::Base

  has_many :deals
  has_many :merchants, through: :deals
  has_many :cities, through: :deals

end 