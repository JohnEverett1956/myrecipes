class AddNameToIngredients < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :name, :string
  end
end
