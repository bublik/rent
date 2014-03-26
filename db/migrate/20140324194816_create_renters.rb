class CreateRenters < ActiveRecord::Migration
  def change
    create_table :renters do |t|
      t.string :phone
      t.string :email
      t.datetime :guard_time
      t.string :town
      t.integer :rooms
      t.integer :amount
      t.datetime :check_in
      t.string :description

      t.timestamps
    end
  end
end
