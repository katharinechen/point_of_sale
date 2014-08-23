require 'spec_helper'

describe "Product" do 
	it "validates presence of name for the product" do 
		new_product = Product.new({:name => ''})
		expect(new_product.save).to eq false 
	end

	it "ensures the length of is at most 20 characters" do 
		new_product = Product.new({:name => "zxcvbnmasdfghjklqwertyuiop"})
		expect(new_product.save).to eq false
	end 

	it "validates presence of price for the product" do 
		new_product = Product.new({:price => ''})
		expect(new_product.save).to eq false 
	end  

	it "validates presence of quantity for the product" do 
		new_product = Product.create({:name => "Ice cream", :price => "15.00", :quantity => 5.5}) 
		expect(new_product.save).to eq false 
	end 

	it 'titleizes the name of the product' do 
		new_product = Product.create({:name => "Ice cream", :price => "15.00", :quantity => 5})
		expect(new_product.name).to eq "Ice Cream"
	end 

	describe :add_product do 
		it "should add a specific number of products to the total quantity of the product" do 
			new_product = Product.create({:name => "Ice Cream", :price => "15.00", :quantity => 5})
			new_product.add_product(10)
			expect(new_product.quantity).to eq 15 
		end 
	end 

	describe :subtract_product do 
		it "should add a specific number of products to the total quantity of the product" do 
			new_product = Product.create({:name => "Ice Cream", :price => "15.00", :quantity => 5})
			new_product.add_product(10)
			expect(new_product.quantity).to eq 15 
		end 
	end 

	describe :restock_less_than_five do 
		it "should list all of the products where quantity is less than five" do 
			new_product1 = Product.create({:name => "Ice Cream", :price => "15.00", :quantity => 5})
			new_product2 = Product.create({:name => "Yogurt", :price => "10.00", :quantity => 2})
			new_product3 = Product.create({:name => "Sandwiches", :price => "7.00", :quantity => 8})
			expect(Product.restock_less_than_five).to eq [new_product2]
		end 
	end 

end 