class ChangeDataTypeForNumberRestaurantTable < ActiveRecord::Migration[5.2]
  def change
    change_column :restaurants, :number, :text
  end
end
