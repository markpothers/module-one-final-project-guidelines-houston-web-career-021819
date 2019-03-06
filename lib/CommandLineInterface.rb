class CommandLineInterface

  def greet
    puts "Welcome to TMK Car Maintenance Finder, the comand line solution for finding good deals on car maintenance throughout the major cities of the US!"
  end

  def choose_city
    puts "We can help you find good deals on car maintenance in the major cities of the US"
    puts "Select your city to begin"
    City.all.each do |city|
      puts "#{city.id}. #{city.name}"
    end
    gets.chomp
  end

  def choose_service
    puts "We can help you find a number of different types of services for your car.  Please choose from the following list."
      services = Product.all.map do |product|
          product.service
      end
      unique_services = services.uniq
      unique_services.each_with_index do |service, index|
      puts "#{index + 1}. #{service}."
    end
    gets.chomp
  end






  def goodbye
    puts "Thanks for using the TMK Car Maintenance Finder.  Goodbye!"
  end

  def run
    greet
    input = choose_city
    input = choose_service
 
 
    binding.pry
    goodbye
  end


end


