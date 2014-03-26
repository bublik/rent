class AddFreeOrdersToUsers < ActiveRecord::Migration
  def up
    add_column :users, :free_orders, :integer, default: 0, null: false
  end

  def down
    remove_column :users, :free_orders
  end
end
