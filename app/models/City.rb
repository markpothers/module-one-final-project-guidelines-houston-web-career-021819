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



        def self.city_size_deals
          city_size_deals = self.all.map do | city |
            city.deals.length

          end
        
        city_with_most_deals = self.all.select do |city|
            city.deals.length == city_size_deals.max
          end 
          
         city_with_most_available_deals = [ "The largest number of deals available in any city is #{city_size_deals.max}",
          ", and this many deals are available in"]
          city_with_most_deals.each do |city|
            city_with_most_available_deals << " #{city.name}"
            city_with_most_available_deals << ","
         end
         city_with_most_available_deals.pop
         
         if city_with_most_available_deals.length > 1
          city_with_most_available_deals.insert(-2," and") 
         end
         city_with_most_available_deals << "."
         puts city_with_most_available_deals.join("")
         binding.pry
        end 
        
        end 

      


     


