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

  def self.highest_average_discount
    each_city_number_of_deals = (City.all.map do |city|          #creates and array of the total number of deals offered in each city
                                    city.deals.length
                                    end)

    city_discount_sums = (City.all.map do |city|              #creates and array of the sum of all the discounts offered in each city
                                discounts = city.deals.map do |deal| 
                                  deal.discount
                                end
                                discounts.inject(:+)
                              end)
    
    city_average_discounts = []      #divides the content of the two arrays by each other to create an array with the average for each city
    counter = 0
    until counter == each_city_number_of_deals.length
      average = (city_discount_sums[counter]/each_city_number_of_deals[counter]).to_i
      city_average_discounts << average
      counter += 1
    end
    puts "The most competitivie city to live in #{City.all.find((city_average_discounts.each_with_index.max[1])+1).name} offering an average discount of #{city_average_discounts.max}% across #{City.all.find((city_average_discounts.each_with_index.max[1])+1).deals.length} deals from #{City.all.find((city_average_discounts.each_with_index.max[1])+1).merchants.length} merchants."
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
        end 
        
        end 

      


     


