class AddUserIdToRent < ActiveRecord::Migration
  def up
    add_column :renters, :user_id, :integer, null: false, default: 1
  end

  def down
    remove_column :renters, :user_id
  end
end
