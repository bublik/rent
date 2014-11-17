class AddTownIdToRenterTable < ActiveRecord::Migration
  def up
    add_column :renters, :town_id, :integer
    Renter.update_all('town_id = 1')
  end

  def down
    remove_column :renters, :town_id
  end
end
