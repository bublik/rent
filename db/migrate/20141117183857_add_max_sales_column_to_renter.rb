class AddMaxSalesColumnToRenter < ActiveRecord::Migration
  def up
    add_column :renters, :max_sales, :integer
  end

  def down
    remove_column :renters, :max_sales
  end
end
