class CreateStore < ActiveRecord::Migration
  def change
    create_table :stores do |t|
    	t.column :name, :string 
    	t.timestamps 
    end

    create_table :stores_cashiers, id: false do |t| 
        t.belongs_to :store 
        t.belongs_to :cashier 
    end 
  end
end


