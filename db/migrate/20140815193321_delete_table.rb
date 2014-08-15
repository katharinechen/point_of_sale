class DeleteTable < ActiveRecord::Migration
  def change
  	drop_table :new_belongs_tos
  end
end
