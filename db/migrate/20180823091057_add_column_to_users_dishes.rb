class AddColumnToUsersDishes < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes_users, :rating, :integer
    add_column :restaurants_users, :rating, :integer
  end
end
