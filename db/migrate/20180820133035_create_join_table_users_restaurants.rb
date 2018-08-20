class CreateJoinTableUsersRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :restaurants do |t|
      t.integer :user_id
      t.integer :restaurant_id
    end
  end
end
