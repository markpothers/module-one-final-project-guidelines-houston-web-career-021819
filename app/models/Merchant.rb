class Merchant < ActiveRecord::Base

  has_many :deals
  has_many :services, through: :deals
  has_many :cities, through: :deals

  def self.most_discounts   #doesn't handle a tie well
    merchant_discounts = {}
    Deal.all.each do |deal|
      if merchant_discounts[deal.merchant_id] == nil
        merchant_discounts[deal.merchant_id] = 1
      else
        merchant_discounts[deal.merchant_id] += 1
      end
    end
    most_discounts = 0
    best_merchant = {"merchant": 0, "deals": 0}
    merchant_discounts.each do |merchant, deals|
      if deals > most_discounts
        best_merchant[:"merchant"] = merchant
        best_merchant[:"deals"] = deals
        most_discounts = deals
      end
    end
    puts "Across the country, the merchant with the most discounts is #{Merchant.find(4).name} with #{best_merchant[:"deals"]} deals."
    #best_merchant
  end

  def self.highest_average_discount
    each_merchant_number_of_deals = (Merchant.all.map do |merchant|          #creates and array of the total number of deals offered by each merchant
                                    merchant.deals.length
                                    end)

    merchant_discount_sums = (Merchant.all.map do |merchant|              #creates and array of the sum of all the discounts offered by each merchant
                                discounts = merchant.deals.map do |deal| 
                                  deal.discount
                                end
                                discounts.inject(:+)
                              end)
    
    merchant_average_discounts = []      #divides the content of the two arrays by each other to create an array with the average for each merchant
    counter = 0
    until counter == each_merchant_number_of_deals.length
      average = (merchant_discount_sums[counter]/each_merchant_number_of_deals[counter]).to_i
      merchant_average_discounts << average
      counter += 1
    end
    puts "The most generous merchant is #{Merchant.all.find((merchant_average_discounts.each_with_index.max[1])+1).name} offering an average discount of #{merchant_average_discounts.max}%."
  end

  def self.widest_presence
    merchant_branches = {}        #puts all the merchants into a hash with their branch numbers and city numbers
    merchant_cities = {}
    Merchant.all.each do |merchant|
      merchant_branches[merchant.name] = merchant.cities.length
      merchant_cities[merchant.name] = merchant.cities.uniq.length
    end
    most_branches = {"merchant": 0, "branches": 0}          #seaches for the merchant with the most branches from the merchant branches hash
    merchant_branches.each do |merchant, branches|
      if branches > most_branches[:branches]
        most_branches[:merchant] = merchant
        most_branches[:branches] = branches
      end
    end
    most_cities = {"merchant": 0, "cities": 0}          #searches for the merchant with the most cities in the merchant cities hash
    merchant_cities.each do |merchant, cities|
      if cities > most_cities[:cities]
        most_cities[:merchant] = merchant
        most_cities[:cities] = cities
      end
    end
    puts "#{most_branches[:merchant]} has the most branches across the country, with #{most_branches[:branches]} across #{merchant_cities[most_branches[:merchant]]} cities."
    puts "#{most_cities[:merchant]} has the widest reach, being present in #{most_cities[:cities]} cities, and it has #{merchant_branches[most_cities[:merchant]]} branches covering them."
  end



end 