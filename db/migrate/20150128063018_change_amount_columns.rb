class ChangeAmountColumns < ActiveRecord::Migration
  def change
    rename_column :renters, :amount, :amount_from
    rename_column :renters, :amount_grn, :amount_to
  end
end
