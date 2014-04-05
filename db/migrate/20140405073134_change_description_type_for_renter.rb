class ChangeDescriptionTypeForRenter < ActiveRecord::Migration
  def up
    change_column(:renters, :description, :text)
  end

  def down
    say 'Nothing todo!'
  end
end
