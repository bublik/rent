class AddPeopleToRenter < ActiveRecord::Migration
  def up
    add_column :renters, :people, :integer
  end

  def down
    remove_column :renters, :people
  end
end
