class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.boolean :autoopen
      t.string :autoopen_interval

      t.timestamps
    end
    Setting.create(autoopen: false, autoopen_interval: 3)
  end
end
