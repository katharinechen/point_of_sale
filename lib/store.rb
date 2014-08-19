class Store < ActiveRecord::Base 

	has_and_belongs_to_many :cashiers 

	validates :name, :presence => true 

	before_save :titleize_name 

private 
	
	def titleize_name 
		self.name = self.name.split(" ").map { |word| word.capitalize}.join(" ") 
	end 
end 