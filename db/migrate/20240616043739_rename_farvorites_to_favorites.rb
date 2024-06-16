class RenameFarvoritesToFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_table :farvorites,:favorites
  end
end
