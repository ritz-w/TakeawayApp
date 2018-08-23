class CreateRestaurantsRatings < ActiveRecord::Migration[5.2]
  def change
     create_table :restaurants_ratings do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.integer :rating
    end
  end
end
