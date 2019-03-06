class City < ActiveRecord::Base

  has_many :deals
  has_many :merchants, through: :deals
  has_many :services, through: :deals


  def self.city_names
    City.all.map do |city|
      city.name.to_s
    end
  end

  def self.capital_cities
    capital_cities = self.city_names.map do |city|
      array = city.split("_")
        capital_array = array.map do |word|
          word.capitalize
        end
        capital_array.join(" ")
    end
  end



  def desired_service_deals(chosen_service_object_id)
    self.deals.select do |deal|
      deal.service_id == chosen_service_object_id
    end
  end



  






end