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

###<<<<<<< HEAD
  def desired_service_deals(chosen_service_object_id)
    self.deals.select do |deal|
      deal.service_id == chosen_service_object_id
    end
  end
##=======


    def desired_service_deals(chosen_service_object_id)
      self.deals.select do |deal|
        deal.service_id == chosen_service_object_id
      end
##>>>>>>> 53128377f5972524c7f43617754aa8c7ad9cf191
    end
        def self.city_size_deals
          city_size_deals = self.all.map do | city |
            city.deals

          end
        end 

         def something
      city_size_deals.all.select do | deal |
            deal.length
        end 
      end


        def self.most_competitive

         most_competitive = City.all[0]
          City.all.each do | city |
          if city.size_deals > 
            
            very_competitive = city 
           end 
          end 
          very_competitive
        end 
 
 
 
 
      end 


