class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.references :restaurant, null: false, foreign_ke: true
      t.string :name, null: false
      t.string :price, null: false
      t.text :description, null: false
      t.timestamps
    end
  end
end
