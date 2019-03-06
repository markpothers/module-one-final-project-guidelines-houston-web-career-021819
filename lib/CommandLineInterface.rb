require 'tty-prompt'
require_relative '../config/environment'

class CommandLineInterface

  def greet
    puts "Welcome to TMK Car Maintenance Finder, the command line solution for finding good deals on car maintenance throughout the major cities of the US!"
  end

  def choose_city
    prompt = TTY::Prompt.new
    prompt.select("Choose your city", City.capital_cities.sort)
  end

  def choose_service
    prompt = TTY::Prompt.new
    prompt.select("Choose your service", Service.service_types.sort)
  end

  def find_service(chosen_city, chosen_service)
    city = City.find_by(name: chosen_city.downcase)
    service = Service.find_by(service: chosen_service)
    binding.pry
    city.services
  end

  def convert_city(chosen_city)
    city_words = chosen_city.downcase.split(" ")
    city_words.join("_")
  end

  def service_options(available_services, chosen_service, chosen_city)
      puts "Here are you offers for #{chosen_service} services in #{chosen_city}"
    available_services.each do |service|
      puts "Offer: #{service.name} at '#{Merchant.find(service.merchant_id).name}''"
#      puts "#{service.description}"
      puts "Costs just $#{service.deal_price}.  Reduced from $#{service.list_price}.  A #{service.discount}% saving!"
      puts "Call #{service.phone} for more information or come join us over at #{service.address} for immediate service!\n\n"
    end
  end









  def goodbye
    puts "Thanks for using the TMK Car Maintenance Finder.  Goodbye!"
  end

  def run
    greet
    chosen_city = choose_city
    converted_city = convert_city(chosen_city) #converts well formatted city name to searchable in the database
    chosen_city_object = City.find_by(name: converted_city) #finds the city object

    chosen_service = choose_service
    chosen_service_object_id = Service.find_by(service: chosen_service).id       #converts the selected service to a relevant object id

    available_services = chosen_city_object.desired_service_deals(chosen_service_object_id) # creates an array deals on selected service & city
    service_options(available_services, chosen_service, chosen_city) #calls this method which formats the deal for the screen

    goodbye
  end


end


