class AddStateToRenters < ActiveRecord::Migration
  def up
    add_column :renters, :state, :string
  end

  def down
    remove_column :renters, :state
  end
end
