class AddGueardTimeToSetting < ActiveRecord::Migration
  def up
    add_column :settings, :guard_time, :integer, default: 120
  end

  def down
    remove_column :settings, :guard_time
  end

end
