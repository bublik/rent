class ChangeRoomsType < ActiveRecord::Migration
  def change
    change_column :renters, :rooms, :string
  end
end
