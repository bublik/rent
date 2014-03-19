class AddPhoneAndDescriptionToUsers < ActiveRecord::Migration
  def up
    add_column :users, :phone, :string
    add_column :users, :description, :string
  end

  def down
    remove_column :users, :phone
    remove_column :users, :description
  end
end
