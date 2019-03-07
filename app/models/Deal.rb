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
    best_deal
  end 

 # has_many :cities
 # has_many :merchants
 # has_many :products

end 