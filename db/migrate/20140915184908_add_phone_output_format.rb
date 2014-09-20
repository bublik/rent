class AddPhoneOutputFormat < ActiveRecord::Migration
  def up
    add_column :renters, :phone_format, :string, default: 'timer'
  end

  def down
    remove_column :renters, :phone_format
  end
end
