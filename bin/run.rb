require 'pry'
require_relative '../config/environment'


# cities = []
# deals.keys.each do |key|
# 	cities << key.to_s
# end

# capital_cities = cities.map do |city|
#   array = city.split("_")
#   capital_array = array.map do |word|
#     word.capitalize
#   end
#     capital_array.join(" ")
# end





new_cli = CommandLineInterface.new
new_cli.run



