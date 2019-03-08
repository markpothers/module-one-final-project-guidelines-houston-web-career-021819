require 'tty-prompt'
require_relative '../config/environment'

class CommandLineInterface

  #greeting, greets the user and presents top level analytical information
  def greeting
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Welcome to TMK Car Maintenance Finder, the command line solution for finding good deals on car maintenance throughout the major cities of the US!\n\n"
    puts "We have a current database of #{Deal.all.length} deals from #{Merchant.all.length} vendors, #{City.all.length} cities.\n\n"
    puts "#{Deal.best_discount}\n"
    puts "#{City.city_size_deals}\n"
    puts "#{City.highest_average_discount}\n"
    puts "#{Merchant.most_discounts}\n"
    puts "#{Merchant.highest_average_discount}\n"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
  end

  ##converts the chosen city to a format for searching the database
  def convert_city(chosen_city)
    city_words = chosen_city.downcase.split(" ")
    city_words.join("_")
  end

  #allows the user to choose their city
  def choose_city
    city_choices = [City.capital_cities.sort, {name: "Exit", value: "exit"}].flatten
    prompt = TTY::Prompt.new
    chosen_city = prompt.select("Please choose your city", city_choices)
    converted_city = convert_city(chosen_city)                        #converts well formatted city name to searchable in the database
      if chosen_city != "exit"
    chosen_city_object = City.find_by(name: converted_city)           #finds the city object
      else
        chosen_city_object = "exit"
      end
    end

  #allows the user to choose their service option
  def choose_service (chosen_city_object)
    service_options = chosen_city_object.local_services
    prompt = TTY::Prompt.new
    chosen_service = prompt.select("Choose your service", service_options)
      if chosen_service != "exit"
        chosen_service_object_id = Service.find_by(service: chosen_service).id       #converts the selected service to a relevant object id
      else
        chosen_service_object_id = "exit"
      end
  end

  #asks the user if they want to run another search or exit
  def go_again
    choices = ["Begin a new search", {name: "No thanks, I'm done (exit)", value: "exit"}]
    prompt = TTY::Prompt.new
    go_again_choice = prompt.select("Would you like to search again?", choices)
  end

  #uses city and service choices to search for deals on that service-type in that city
  def find_local_services(chosen_city_object, chosen_service_object_id)
      available_services = chosen_city_object.desired_service_deals(chosen_service_object_id) # creates an array deals on selected service & city
  end

  # takes the array of service options from "find_local_services" and formats them appropriately
  def presented_service_options(available_services, chosen_service, chosen_city)
    deal_choice = "choice"
    if available_services == []
      puts "Unfortunately we have no offers for #{chosen_service} services in #{chosen_city} today."
    else
      puts "Here are you offers for #{chosen_service} services in #{chosen_city}:\n\n"
      deals = []
      counter = 1
        available_services.each do |service|
          deals << {name: "Offer #{counter}:
            #{service.name} at '#{Merchant.find(service.merchant_id).name}'
          Costs just $#{service.deal_price}.  Reduced from $#{service.list_price}.  A #{service.discount.to_i}% saving!
          Call #{service.phone} for more information or come join us over at #{service.address} for immediate service!
          Visit us online at #{service.url} to learn more.", value: service.url}
          counter += 1
        end
        deals << {name: "Exit", value: "exit"}
        prompt = TTY::Prompt.new
        deal_choice = prompt.select("Select a deal to view the offer online:", deals)
          if deal_choice != "exit"
            Launchy.open(deal_choice)
          end
    end
    deal_choice
  end

  #goodbye
  def goodbye
    puts "Thanks for using the TMK Car Maintenance Finder.  Goodbye!"
  end

  def database_update
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

#    deals[:"houston"]["deals"][0]["deal"]["provider_slug"]

    deals.each do |city|
      city[1]["deals"].each do |indiv|
        binding.pry
        if indiv["deal"]["short_title"].include("Oil Change") ||indiv["deal"]["short_title"].include("oil change") 
         indiv["deal"]["provider_slug"] = "oil change"
        end


        
  end

  end

















  def run
    greeting
    binding.pry
 
    go_again_choice = "search_again" # preset some variable for the loop
    chosen_service_object_id = 1
    chosen_city_object = City.all[0]
    deal_choice = "choice"

    until go_again_choice == "exit" || chosen_service_object_id == "exit" || chosen_city_object == "exit" || deal_choice == "exit" # loop through the options until the user chooses to exit somewhere
      chosen_city_object = choose_city   #offers the user a choice of city; returns the object
        if chosen_city_object != "exit"
          chosen_service_object_id = choose_service(chosen_city_object)  #offers choice of service and returns id
        end
        if chosen_city_object != "exit" && chosen_service_object_id != "exit"
          local_services = find_local_services(chosen_city_object, chosen_service_object_id)
          deal_choice = presented_service_options(local_services, Service.find(chosen_service_object_id).service, chosen_city_object.capital_name)  #calls this method which lists the deals
        end
            if deal_choice != "exit" && chosen_service_object_id != "exit" && chosen_city_object != "exit"
              go_again_choice = go_again
            end              #offers the choice to go again or simply exit
    end

    goodbye
  end

end
