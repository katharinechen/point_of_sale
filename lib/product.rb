class Product < ActiveRecord::Base 
	belongs_to :cashier 

	validates :name, :presence => true, :length => { :maximum => 20}
	validates :price, :presence => true 

	before_save :titleize_name 

private 
	
	def titleize_name 
		self.name = self.name.split(" ").map! { |word| word.capitalize}.join(" ") 
	end 

end 