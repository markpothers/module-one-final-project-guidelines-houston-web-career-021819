require 'tty-prompt'
require_relative '../config/environment'

class CommandLineInterface

  #greeting
  def greeting
    puts "Welcome to TMK Car Maintenance Finder, the command line solution for finding good deals on car maintenance throughout the major cities of the US!"
  end

  ##converts the chosen city to a format for searching the database
  def convert_city(chosen_city)
    city_words = chosen_city.downcase.split(" ")
    city_words.join("_")
  end

  #allows the user to choose their city
  def choose_city
    prompt = TTY::Prompt.new
    chosen_city = prompt.select("Please choose your city", City.capital_cities.sort)
    converted_city = convert_city(chosen_city)                        #converts well formatted city name to searchable in the database
    chosen_city_object = City.find_by(name: converted_city)           #finds the city object
  end

  #allows the user to choose between a specific service or just seeing some great info about deals
  def service_or_deal
    prompt = TTY::Prompt.new
    prompt.select("Are you looking for a particular service, or just a GREAT DEAL?", %w(service deal) )
  end

  #allows the user to choose their service option
  def choose_service
    prompt = TTY::Prompt.new
    chosen_service = prompt.select("Choose your service", Service.service_types.sort)
    chosen_service_object_id = Service.find_by(service: chosen_service).id       #converts the selected service to a relevant object id
  end

  def cool_info
    puts "Some cool info"
  end

  #asks the user if they want to run another search or exit
  def go_again
    prompt = TTY::Prompt.new
    go_again_choice = prompt.select("Would you like to search again?", %w(search_again exit) )
  end

  #uses city and service choices to search for deals on that service-type in that city
  def find_local_services(chosen_city_object, chosen_service_object_id)
      available_services = chosen_city_object.desired_service_deals(chosen_service_object_id) # creates an array deals on selected service & city
  end

  # takes the array of service options from "find_local_services" and formats them appropriately
  def service_options(available_services, chosen_service, chosen_city)
    if available_services == []
      puts "Unfortunately we have no offers for #{chosen_service} services in #{chosen_city} today."
    else
      puts "Here are you offers for #{chosen_service} services in #{chosen_city}:\n\n"
        counter = 1
      available_services.each do |service|
        puts "Offer #{counter}:"
        puts "  #{service.name} at '#{Merchant.find(service.merchant_id).name}''"
        puts "  Costs just $#{service.deal_price}.  Reduced from $#{service.list_price}.  A #{service.discount}% saving!"
        puts "  Call #{service.phone} for more information or come join us over at #{service.address} for immediate service!\n\n"
        counter += 1
      end
    end
  end

  #goodbye
  def goodbye
    puts "Thanks for using the TMK Car Maintenance Finder.  Goodbye!"
  end

 

  def run
    greeting
  
    go_again_choice = "search_again"
  binding.pry
    until go_again_choice == "exit"               # loop through the options until the user chooses to exit in the go_again method
      chosen_city_object = choose_city            #offers the user a choice of cities and returns the object for the selected city
      service_or_deal_choice = service_or_deal     #offers a choice between specific service or general deals and returns info
      service_choice = (
                        if service_or_deal_choice == "service"
                          chosen_service_object_id = choose_service
                        else
                          cool_info
                        end
                      )
      local_services = find_local_services(chosen_city_object, service_choice)
      service_options(local_services, Service.find(service_choice).service, chosen_city_object.name)    #calls this method which lists the deals
      go_again_choice = go_again                                                              #offers the choice to go again or simply exit
    end

    goodbye
  end

end
