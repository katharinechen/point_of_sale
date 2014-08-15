require 'pg'
require 'active_record'
require './lib/product'
require './lib/cashier'
require 'pry'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def header 
	system 'clear'
	puts "Welcome!"
end 

def main_menu 
	header 
	answer = nil  
	until answer == 3 
		puts "Press '1' if you are a store manager."
		puts "Press '3' if you want to exit the program."
		answer = gets.chomp.to_i  

		case answer 
		when 1 
			store_manager_menu
		when 3
			exit_routine
		else 
			puts "Please enter a valid option."
		end 
	end 
end 

def store_manager_menu	
	header 	
	answer = nil 
	until answer == 5 
		puts "Press '1' if you want to work with products."
		puts "Press '2' if you want to work with logins for cashiers."
		puts "Press '4' if you want to return to the main menu."
		puts "Press '5' if you want to exit."
		answer = gets.chomp.to_i 

		case answer 
		when 1
			product_menu 
		when 2 
			login_crud_menu
		when 4
			main_menu
		when 5
			exit_routine
		else
			puts "Please enter a valid option."
		end
	end 
end

def login_crud_menu 
	header
	answer = nil 

	until answer == 5 
		puts "Press '1' to create logins for cashiers."
		puts "Press '2' to edit logins for cashiers."
		puts "Press '3' to list logins for cashiers."
		puts "Press '4' to return to the previous menu."
		puts "Press '5' to exit."
		answer = gets.chomp.to_i 

		case answer 
		when 1 
			create_login
		when 2
			edit_login
		when 3
			list_login
		when 4
			store_manager_menu
		when 5
			exit_routine
		else
			puts "Please enter a valid option."
		end
		sleep 2.0
		header
		login_crud_menu
	end 
end 

def create_login
	puts "Please enter the name of the cashier."
	cashier_name = gets.chomp 
	puts "Please enter the login you want to create for this cashier."
	cashier_login = gets.chomp.capitalize 

	new_cashier = Cashier.new(name: cashier_name, login: cashier_login)
	new_cashier.save 

	puts "You have successfully added #{new_cashier.name}. #{new_cashier.login} has #{cashier_login} as his/her login username."
end 

def edit_login 
	puts "Please enter the user of the login you want to edit."
	cashier_name = gets.chomp 
	puts "What is the new login you want to assign this cashier?"
	new_login = gets.chomp

	selected_cashier = Cashier.find_by(name: cashier_name)
	selected_cashier.update(login: new_login)

	puts "You have successfully change the login for #{cashier_name}."
end 

def list_login 
	puts "Here is the list of all your logins:"
	login_list = Cashier.all 
	login_list.each do |cashier| 
		puts "Name: #{cashier.name} Login: #{cashier.login}"
	end 
end 

def product_menu
	answer = nil 
	until answer == 5 
		header 
		system 'clear'
		puts "Press '1' to add a product."
		puts "Press '2' to delete a product."
		puts "Press '3' to list all products."
		puts "Press '4' to return to the previous menu."
		puts "Press '5' to exit."
		answer = gets.chomp.to_i 

		case answer 
		when 1
			add_product
		when 2
			delete_product
		when 3 
			list_products 
		when 4
			store_manager_menu
		when 5 
			exit_routine
		else
			puts "Please enter a valid option."
		end
	end 
end 

def add_product
	puts "Please enter the name of the product you want to add:"
	product_name = gets.chomp.capitalize  
	puts "Please enter the price of the object (e.g. 14.00):"
	product_price = gets.chomp 

	new_product = Product.new(name: product_name, price: product_price)
	new_product.save 
	puts "You have successfully add #{product_name}. #{product_name} will be selling for $#{product_price}."
end 

def delete_product 
	list_products 
	puts " "
	puts "Please enter the name of the product you want to delete:"
	delete_product_name = gets.chomp.capitalize 
	selected_product = Product.find_by(name: delete_product_name)
	selected_product.destroy 
	puts "You have successfully deleted #{delete_product_name}."
end 

def list_products 
	puts "Here is a list of all of the products you have listed in your store."
	product_list = Product.all 
	product_list.each do |product|
		puts "Name: #{product.name} Price: #{product.price}"
	end 
end 

def exit_routine 
	puts "Have a great day!"
	sleep 0.8
	exit 
end 

main_menu 