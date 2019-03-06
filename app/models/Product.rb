class Product < ActiveRecord::Base

  has_many :deals
  has_many :merchants, through: :deals
  has_many :cities, through: :deals


  def self.services
    all_services = self.all.map do |product|
      product.service
    end
    all_services.uniq
  end


end 