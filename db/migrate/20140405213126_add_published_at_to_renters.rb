class AddPublishedAtToRenters < ActiveRecord::Migration
  def up
    add_column :renters, :published_at, :datetime
  end

  def down
    remove_column :renters, :published_at
  end

end
