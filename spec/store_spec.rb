require 'spec_helper'

describe "Store" do 

	it "validates presence of name for the store" do 
		new_store = Store.new({:name => " "})
		expect(new_store.save).to eq false 
	end 

	it "titleizes the name of the store" do 
		new_store = Store.create({:name => "west Side"})
		expect(new_store.name).to eq "West Side"
	end 
end 