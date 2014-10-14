class AddAuthTokenToUser < ActiveRecord::Migration
  def up
    add_column :users, :auth_token, :string
    User.all.each do |user|
      user.save
    end
  end

  def down
    remove_column :users, :auth_token
  end
end
