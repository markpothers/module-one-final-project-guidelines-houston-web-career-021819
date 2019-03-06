class City < ActiveRecord::Base

  has_many :deals
  has_many :merchants, through: :deals
  has_many :services, through: :deals

end