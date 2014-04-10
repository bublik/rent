class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.references :user, index: true
      t.references :renter, index: true
      t.integer :counter

      t.timestamps
    end
  end
end
