class Product < ActiveRecord::Base 

	belongs_to :cashier 

	validates :name, :presence => true, :length => { :maximum => 20}
	validates :price, :presence => true 
	validates :quantity, :presence => true, numericality: { only_integer: true }

	before_save :titleize_name 

	def add_product(number)
		self.quantity = self.quantity + number 
		puts "You have successfully increased the quantity of #{self.name} by #{number}. There are currently #{self.quantity} #{self.name}."
		self.save 
	end 

	def subtract_product(number)
		self.quantity = self.quantity - number 
		self.save 
		puts "You have successfully decreased the quantity of #{self.name} by #{number}. There are currently #{self.quantity} #{self.name}."
	end 

private 
	
	def titleize_name 
		self.name = self.name.split(" ").map { |word| word.capitalize}.join(" ") 
	end 

end 