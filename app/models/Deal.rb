class Deal < ActiveRecord::Base

  belongs_to :city
  belongs_to :merchant
  belongs_to :service


  def self.best_discount
    best_deal = Deal.all[0]
    Deal.all.each do | deal|
      if deal.discount > best_deal.discount
        best_deal = deal
      end
    end
    puts "The best car maintenance deal in America right now is #{best_deal.name} at #{Merchant.find(best_deal.merchant_id).name}."
    puts "Head to #{Merchant.find(best_deal.merchant_id).name} to take advantage now!!!!!!!!!"
  end

end