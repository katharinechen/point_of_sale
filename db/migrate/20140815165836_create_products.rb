class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.column :name, :string 
    	t.column :name, :decimal, :precision => 8, :scale => 2 

    	t.timestamps 
    end
  end
end
