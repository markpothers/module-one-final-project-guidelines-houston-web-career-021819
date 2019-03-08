require 'pry'
require 'rest-client'
require 'json'

class Database

  attr_accessor :deals

  def initialize(deals={})
    @deals = deals
  end

  def data_download
    houston = RestClient.get "https://api.discountapi.com/v2/deals?api_key=WkXDXfXX&location=29.7604, -95.3698&radius=50&provider_slugs=groupon&category_slugs=automotive-services"
    parsed_houston = JSON.parse(houston.body)

    san_antonio = RestClient.get "https://api.discountapi.com/v2/deals?api_key=WkXDXfXX&location=29.4241, -98.4936&radius=50&provider_slugs=groupon&category_slugs=automotive-services"
    parsed_san_antonio = JSON.parse(san_antonio.body)

    chicago = RestClient.get "https://api.discountapi.com/v2/deals?api_key=WkXDXfXX&location=41.8781, -87.6298&radius=50&provider_slugs=groupon&category_slugs=automotive-services"
    parsed_chicago = JSON.parse(chicago.body)

    atlanta = RestClient.get "https://api.discountapi.com/v2/deals?api_key=WkXDXfXX&location=33.7490, -84.3880&radius=50&provider_slugs=groupon&category_slugs=automotive-services"
    parsed_atlanta = JSON.parse(atlanta.body)

    los_angeles = RestClient.get "https://api.discountapi.com/v2/deals?api_key=WkXDXfXX&location=34.0522, -118.2437&radius=50&provider_slugs=groupon&category_slugs=automotive-services"
    parsed_los_angeles = JSON.parse(los_angeles.body)

    new_york = RestClient.get "https://api.discountapi.com/v2/deals?api_key=WkXDXfXX&location=40.7128, -74.0060&radius=50&provider_slugs=groupon&category_slugs=automotive-services"
    parsed_new_york = JSON.parse(new_york.body)

    washington = RestClient.get "https://api.discountapi.com/v2/deals?api_key=WkXDXfXX&location=38.9072, -77.0369&radius=50&provider_slugs=groupon&category_slugs=automotive-services"
    parsed_washington = JSON.parse(washington.body)

    philadelphia = RestClient.get "https://api.discountapi.com/v2/deals?api_key=WkXDXfXX&location=39.9526, -75.1652&radius=50&provider_slugs=groupon&category_slugs=automotive-services"
    parsed_philadelphia = JSON.parse(philadelphia.body)

    deals = {}
    deals[:"houston"] = parsed_houston
    deals[:"san_antonio"] = parsed_san_antonio
    deals[:"chicago"] = parsed_chicago
    deals[:"atlanta"] = atlanta
    deals[:"los_angeles"] = los_angeles
    deals[:"new_york"] = new_york
    deals[:"washington"] = washington
    deals[:"philadelphia"] = philadelphia

    self.deals = deals
  end

  def deals_modifier
    self.deals.each do |city|
      city[1]["deals"].each do |indiv|
        if indiv["deal"]["short_title"].include?("window tinting")||indiv["deal"]["short_title"].include?("Window Tinting")
          indiv["deal"]["provider_slug"] = "window tinting"
        end
        if indiv["deal"]["short_title"].include?("camera") ||indiv["deal"]["short_title"].include?("Camera") 
          indiv["deal"]["provider_slug"] = "camera"
        end
        if indiv["deal"]["short_title"].include?("remote") ||indiv["deal"]["short_title"].include?("Remote") 
          indiv["deal"]["provider_slug"] = "remote"
        end
        if indiv["deal"]["short_title"].include?("heated seat")
          indiv["deal"]["provider_slug"] = "heated seat"
        end
        if indiv["deal"]["short_title"].include?("hail") ||indiv["deal"]["short_title"].include?("Hail") 
          indiv["deal"]["provider_slug"] = "hail"
        end
        if indiv["deal"]["short_title"].include?("wash") ||indiv["deal"]["short_title"].include?("detail") ||indiv["deal"]["short_title"].include?("Wash")
          indiv["deal"]["provider_slug"] = "detail"
        end
        if indiv["deal"]["short_title"].include?("wax") ||indiv["deal"]["short_title"].include?("polish") 
          indiv["deal"]["provider_slug"] = "wax"
        end
        if indiv["deal"]["short_title"].include?("Oil Change") ||indiv["deal"]["short_title"].include?("oil change") 
        indiv["deal"]["provider_slug"] = "oil change"
        end
        if indiv["deal"]["short_title"].include?("brake") ||indiv["deal"]["short_title"].include?("Brake") 
          indiv["deal"]["provider_slug"] = "brakes"
        end
      end
binding.pry
    end
  end

end

mark = Database.new
mark.data_download
mark.deals_modifier

binding.pry

puts "all done"
