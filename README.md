# Point of Sale 

##About 
This project is completed by Katharine Chen for the Active Record assessment for Epicodus. 

##Description 
The objective of this project is to make a super basic point of sale (POS) system for a convenience store, using Active Record. A POS is a system that lets cashiers ring up customers for their purchase. The project must include at least one one-to-many relationship, and one many-to-many relationship, using at least one scope, validation, and callback.  

##Functionality 

* Store managers can add a new product to the POS, with its name, price, and available quantity, so they can keep track of what we're selling.
* Store managers can update the quantity of a specific product. 
* Store managers can create logins for cashiers, so store managers know who is responsible for ringing up which purchases.
* Cashiers can work in many stores. Stores can have many cashiers. 
* Store Managers can assign cashiers to work at specific stores. 
* Store Managers can generate a list of cashiers for each specific store, as well as a list of stores for each cashier. 
* Store Manager can list products with quantity that is less than five to restock. 

##Installation 

Clone the repository in your terminal. 
	
	git clone https://github.com/katharinechen/point_of_sale.git 

Bundle install all of the gems. 

	bundle 

To run the program, run user_interface.rb in the terminal. 

	ruby user_interface.rb 

##License

MIT