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
    best_merchant
  end

  def self.highest_average_discount
    Deal.all.select do |deal|
      deal.city_id = self.id
    end

  end

  def self.widest_presence
    merchant_branches = {}
    merchant_cities = {}
    Merchant.all.each do |merchant|
      merchant_branches[merchant.name] = merchant.cities.length
      merchant_cities[merchant.name] = merchant.cities.uniq.length
    end
    most_branches = {"merchant": 0, "branches": 0}
    merchant_branches.each do |merchant, branches|
      if branches > most_branches[:branches]
        most_branches[:merchant] = merchant
        most_branches[:branches] = branches
      end
    end
    most_cities = {"merchant": 0, "cities": 0}
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