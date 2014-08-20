require 'pg'
require 'active_record'
require './lib/product'
require './lib/cashier'
require './lib/store'
require 'pry'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def header 
	system 'clear'
	puts "Welcome!"
end 

def main_menu 
	header 
	answer = nil  
	until answer == 2 
		puts "Press '1' if you are a store manager."
		puts "Press '2' if you want to exit the program."
		answer = gets.chomp.to_i  

		case answer 
		when 1 
			store_manager_menu
		when 2
			exit_routine
		else 
			puts "Please enter a valid option."
		end 
	end 
end 

def store_manager_menu	
	header 	
	answer = nil 
	until answer == 6 
		puts "Press '1' if you want to work with products."
		puts "Press '2' if you want to work with logins for cashiers."
		puts "Press '3' if you want to work with stores."
		puts "Press '4' to work with assignments."
		puts "Press '5' if you want to return to the main menu."
		puts "Press '6' if you want to exit."

		answer = gets.chomp.to_i 

		case answer 
		when 1
			product_menu 
		when 2 
			login_crud_menu
		when 3
			store_menu 
		when 4 
			assignments_menu 
		when 5
			main_menu
		when 6
			exit_routine
		else
			puts "Please enter a valid option."
		end
	end 
end

def store_menu 
	header
	answer = nil 

	until answer == 5 
		puts "Press '1' to create stores."
		puts "Press '2' to delete stores."
		puts "Press '3' to list stores."
		puts "Press '4' to return to the previous menu."
		puts "Press '5' to exit."
		answer = gets.chomp.to_i 

		case answer 
		when 1 
			create_store 
		when 2
			delete_store
		when 3 
			list_store 
		when 4
			store_manager_menu
		when 5
			exit_routine
		else
			puts "Please enter a valid option."
		end
		sleep 2.0
		header
		store_menu 
	end 
end 

def create_store
	puts "Please enter the name of the store."
	store_name = gets.chomp 
	new_store = Store.create(name: store_name)
	puts "You have successfully added #{store_name}." 
end 

def delete_store
	list_store 
	puts " "
	puts "Please enter the name of the store you want to delete:"
	deleted_store = gets.chomp.capitalize 
	selected_store = Store.find_by(name: deleted_store)
	selected_store.destroy 
	puts "You have successfully deleted #{deleted_store}."
end

def list_store
	puts "Here is the list of all your stores:"
	store_list = Store.all 
	store_list.each do |store| 
		puts "#{store.name}"
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
	list_login
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
		puts "Press '4' to update the quantity."
		puts "Press '5' to return to the previous menu."
		puts "Press '6' to exit."
		answer = gets.chomp.to_i 

		case answer 
		when 1
			add_product
		when 2
			delete_product
		when 3 
			list_products 
		when 4
			update_quantity 
		when 5
			store_manager_menu
		when 6 
			exit_routine
		else
			puts "Please enter a valid option."
		end
		sleep 3.0
	end 
end 

def update_quantity 
	puts "Please enter the name of the product you want to update:"
	product_name = gets.chomp.capitalize
	product = Product.find_by(name: "#{product_name}")

	puts "Do you want to add or subtract product? Press 'A' to add, or 'B' to subtract."
	answer = gets.chomp.downcase 

	puts "How many?"
	number = gets.chomp.to_i 

	case answer 
	when "a"
		product.add_product(number)
	when "b"
		product.subtract_product(number)
	else
		puts "Please enter a valid option."
	end
end 

def add_product
	puts "Please enter the name of the product you want to add:"
	product_name = gets.chomp.capitalize  
	puts "Please enter the price of the object (e.g. 14.00):"
	product_price = gets.chomp 
	puts "Please enter the quantity of the object (e.g. 5):"
	quantity = gets.chomp 

	new_product = Product.new(name: product_name, price: product_price, quantity: quantity)
	if new_product.save 
		puts "You have successfully add #{product_name}. #{product_name} will be selling for $#{product_price}. There are currently #{quantity} available."
	else 
		puts "Attempt failed. Please enter both a name and a price for the product."
		new_product.errors.full_messages.each { |message| puts message }
		add_product
	end
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
		puts "Name: #{product.name} Price: $#{product.price} Amount: #{product.quantity}"
	end 
end 

def exit_routine 
	puts "Have a great day!"
	sleep 0.8
	exit 
end 

def assignments_menu 
	answer = nil 
	until answer == 5 
		header 
		system 'clear'
		puts "Press '1' to add or delete an assignment."
		puts "Press '3' to list all assignments by cashier."
		puts "Press '4' to list all assignments by store"
		puts "Press '5' to return to the previous menu."
		puts "Press '6' to exit."
		answer = gets.chomp.to_i 

		case answer 
		when 1
			add_or_delete_assignment 
		when 3 
			list_assignment_by_cashier 
		when 4
			list_assignment_by_store  
		when 5
			store_manager_menu
		when 6 
			exit_routine
		else
			puts "Please enter a valid option."
		end
		sleep 3.0
	end 
end 

def add_or_delete_assignment
	puts "Here is the list of stores."
	store_list = Store.all 
	store_list.each do |store|
		puts "#{store.name}"
	end

	puts " "

	puts "Here is the list of cashiers."
	cashier_list = Cashier.all 
	cashier_list.each do |cashier| 
		puts "#{cashier.name}"
	end 

	puts "Select a store."
	store = gets.chomp
	store = titleize(store)
	selected_store = Store.find_by(name: store)

	puts "Select a cashier."
	cashier = gets.chomp
	cashier = titleize(cashier)
	selected_cashier = Cashier.find_by(name: cashier)

	puts "Do you want to add or delete the association?"
	puts "Press '1' to add."
	puts "Press '2' to delete."
	choice = gets.chomp.to_i

	case choice
	when 1 
		selected_cashier.stores << selected_store 
		puts "You have successfully added #{selected_cashier.name} to #{selected_store.name}."
	when 2 
		selected_cashier.stores.delete(selected_store)
		puts "You have successfully added #{selected_cashier.name} to #{selected_store.name}."
	else
		puts "Please put a valid option."
		sleep 1.0 	
		add_or_delete_assignment
	end 
end 

def list_assignment_by_cashier
	puts "Here is a list of all stores each cashier works at." 
	cashiers = Cashier.all 

	cashiers.each do |cashier| 
		puts cashier.name 
		if cashier.stores == []
			puts "This cashier is currently not working at any stores."
		else 
			cashier.stores.each do |store|
				puts store.name 
			end
		end
		puts " "  
	end 	
end

def list_assignment_by_store
	puts "Here is a list of all cashiers and the stores they work at." 
	stores = Store.all 
	stores.each do |store| 
		puts "Store: #{store.name}"
		if store.cashiers == []
			puts "There are no cashiers currently working at this store."
		else 
			store.cashiers.each do |cashier|
				puts cashier.name 
			end
		end
		puts " "  
	end 	
end

def titleize(input)
	input = input.split(" ").map! { |word| word.capitalize}.join(" ")
	input 
end 

main_menu 