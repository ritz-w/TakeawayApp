class CreateDishesRatings < ActiveRecord::Migration[5.2]
  def change
       create_table :dishes_ratings do |t|
        t.integer :user_id
        t.integer :dish_id
        t.integer :rating
      end
    end
  end
