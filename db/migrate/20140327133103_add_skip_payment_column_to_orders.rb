class AddSkipPaymentColumnToOrders < ActiveRecord::Migration
  def up
    add_column :orders, :skip_payment, :boolean, default: false, null: false
  end

  def down
    remove_column :orders, :skip_payment
  end
end
