class ShowCheckInFlag < ActiveRecord::Migration
  def change
    change_table :renters do |t|
      t.boolean :show_check_in, default: true, null: false
      t.boolean :show_check_out, default: true, null: false
    end
  end
end
