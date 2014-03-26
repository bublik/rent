class AddSubscribeColumnToUsers < ActiveRecord::Migration
  def up
    add_column :users, :subscribe, :boolean, null: false, default: true
  end

  def down
    remove_column :users, :subscribe
  end

end
