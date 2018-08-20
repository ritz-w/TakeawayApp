class CreateJoinTableUsersDishes < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :dishes do |t|
      t.integer :user_id
      t.integer :dish_id
    end
  end
end
