require 'pg'
require 'active_record'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

# def header 
# 	system 'clear'
# 	puts "Welcome!"
# end 

# def main_menu 
# 	header
# 	answer = nil  
# 	puts "Press '1' if you are a store manager."
# 	puts "Press '2' if you are a cashier."
# 	puts "Press '3' if you want to exit the program."
# 	answer = gets.chomp.to_i  

# 	until answer == 3 
# 		case answer 
# 		when 1 
# 			store_manager_menu
# 		when 2 
# 			cahsier_menu
# 		when 3
# 			exit_routine
# 		else 
# 			puts "Please enter a valid option."
# 		end 
# 	end 
# end 

# def store_manager_menu	
# 	header 
# 	answer = nil 
# 	puts "Press '1' if you want to work with products."
# 	puts "Press '4' if you want to return to the main menu."
# 	puts "Press '5' if you want to exit."
# 	answer = gets.chomp.to_i 

# 	until answer == 5 
# 		case answer 
# 		when 1
# 			product_menu 
# 		when 4
# 			main_menu
# 		when 5
# 			exit_routine
# 		else
# 			puts "Please enter a valid option."
# 		end
# 	end 
# end

# def cashier_menu
# end

# def product_menu
# 	header 
# 	answer = nil 
# 	puts "Press '1' to add a product."
# 	puts "Press '2' to delete a product."
# 	puts "Press '3' to list all products."
# 	puts "Press '4' to return to the previous menu."
# 	puts "Press '5' to exit."
# 	answer = gets.chomp.to_i 

# 	until answer == 5 
# 		case answer 
# 		when 1
# 			add_product
# 		when 2
# 			delete_product
# 		when 3 
# 			list_products 
# 		when 4
# 			store_manager_menu
# 		when 5 
# 			exit_routine
# 		else
# 			puts "Please enter a valid option."
# 		end
# 	end 
# end 

# def add_product
# 	puts "Please enter the name of the product you want to add:"
# 	product_name = gets.chomp.capitalize  
# 	puts "Please enter the price of the object (e.g. 14.00):"
# 	product_price = gets.chomp 

# 	new_product = Product.new(name: product_name, price: product_price)
# 	new_product.save 
# 	puts "You have successfully add #{product_name}. #{product_name} will be selling for $#{product_price}."
# end 

# def delete_product 
# 	list_products 
# 	puts " "
# 	puts "Please enter the name of the product you want to delete:"
# 	delete_product_name = gets.chomp.capitalize 
# 	delete_product = Product.find_by(name: delete_product_name)
# 	delete_project.destroy 
# end 

# def list_products 
# 	puts "Here is a list of all of the products you have listed in your store."
# 	product_list = Product.all 
# 	product_list.each do |product|
# 		puts "Name: #{product.name} Price: #{product.price}"
# 	end 
# end 

# def exit_routine 
# 	puts "Have a great day!"
# 	sleep 2.0 
# 	exit 
# end 

# main_menu 