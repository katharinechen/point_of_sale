class Cashier < ActiveRecord::Base 
	has_many :products, dependent: :destroy 
end 


