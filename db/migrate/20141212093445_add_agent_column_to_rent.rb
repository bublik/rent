class AddAgentColumnToRent < ActiveRecord::Migration
  def up
    add_column :renters, :agent, :boolean, default: false
  end

  def down
    remove_column :renters, :agent
  end
end
