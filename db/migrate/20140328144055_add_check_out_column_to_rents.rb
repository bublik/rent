class AddCheckOutColumnToRents < ActiveRecord::Migration
  def up
    add_column :renters, :check_out, :datetime
  end

  def down
    remove_column :renters, :check_out
  end
end
