class AddCountersCashe < ActiveRecord::Migration
  def up
    # количество ордеров у этого пользователя
    add_column :users, :orders_count, :integer, default: 0, null: false
    # количество ордеров оплат за это объявление
    add_column :renters, :orders_count, :integer, default: 0, null: false
    #колличество объявлений которое добавил этот пользователь
    add_column :users, :renters_count, :integer, default: 0, null: false
  end

  def down
    remove_column :users, :orders_count
    remove_column :renters, :orders_count
    remove_column :users, :renters_count
  end
end
