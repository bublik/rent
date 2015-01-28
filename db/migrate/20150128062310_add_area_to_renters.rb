class AddAreaToRenters < ActiveRecord::Migration
  def change
    change_table :renters do |t|
      t.string :town_area
    end
  end
end
