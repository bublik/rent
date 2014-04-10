class AddUserColumnToSetting < ActiveRecord::Migration
  def up
    add_column :settings, :users, :string, default: "--- []\n"
  end

  def down
    remove_column :settings, :users
  end
end
