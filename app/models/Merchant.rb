class Merchant < ActiveRecord::Base

  has_many :deals
  has_many :services, through: :deals
  has_many :cities, through: :deals

end 