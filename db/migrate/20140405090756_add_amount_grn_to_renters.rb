class AddAmountGrnToRenters < ActiveRecord::Migration
  def up
    add_column :renters, :amount_grn, :integer, default: nil
  end

  def down
    remove_column :renters, :amount_grn
  end
end
