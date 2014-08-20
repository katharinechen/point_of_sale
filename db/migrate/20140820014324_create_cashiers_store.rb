class CreateCashiersStore < ActiveRecord::Migration
  def change
    create_table :cashiers_stores, id: false do |t|
    	t.belongs_to :store 
      	t.belongs_to :cashier 
    end

    drop_table :stores_cashiers
  end
end
