class Cashier < ActiveRecord::Base 
	
	has_many :products, dependent: :destroy 
	has_and_belongs_to_many :stores 

	validates :name, :presence => true 
	validates :login, :presence => true 
	validates_associated :products 

	before_save :titleize_name, :login_downcase  

private 
	
	def titleize_name 
		self.name = self.name.split(" ").map { |word| word.capitalize}.join(" ") 
	end 

	def login_downcase 
		self.login = self.login.split(" ").join("").downcase 
	end 

end 


