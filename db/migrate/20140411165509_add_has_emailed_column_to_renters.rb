class AddHasEmailedColumnToRenters < ActiveRecord::Migration
  def up
    add_column :renters, :has_emailed, :boolean, null: false, default: false
  end

  def down
    remove_column :renters, :has_emailed
  end
end
