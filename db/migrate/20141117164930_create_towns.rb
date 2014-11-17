class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :name

      t.timestamps
    end

    ['Одесса', 'Киев', 'Львов', 'Днепропетровск'].each do |name|
      Town.create!(name: name)
    end

  end
end
