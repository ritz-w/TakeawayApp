class CreateJoinTableRestaurantsDishes < ActiveRecord::Migration[5.2]
  def change
    create_join_table :restaurants, :dishes do |t|
      t.integer :restaurant_id
      t.integer :dish_id
    end
  end
end
