class ChangeProducts < ActiveRecord::Migration
  def change
	 change_table(:products) do |t|
	  t.belongs_to :cashiers 
	end
  end
end
