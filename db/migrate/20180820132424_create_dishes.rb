class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :description
      t.string :region
      t.integer :rating
      t.string :photo_1
      t.string :photo_2
      t.string :photo_3
      t.timestamps
    end
  end
end
