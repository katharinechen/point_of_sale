require 'spec_helper'

describe "Cashier" do 
	it "validates presence of name for the cashier" do 
		new_cashier = Cashier.new({:name => " ", :login => "bubblemachine"})
		expect(new_cashier.save).to eq false 
	end 

	it "validates presence of login for cashier" do 
		new_cashier = Cashier.new({:name => "Bubble Machine", :login => " "})
		expect(new_cashier.save).to eq false 
	end 

	it "titleizes the name of the product" do 
		new_cashier = Cashier.create({:name => "peTer pAn", :login => "peterpan"})
		expect(new_cashier.name).to eq "Peter Pan"
	end 

	it "lowercase and make sures that there are not spaces for logins" do 
		new_cashier = Cashier.create({:name => "Peter Pan", :login => "Peter Pan"})
		expect(new_cashier.login).to eq "peterpan"
	end 
end 