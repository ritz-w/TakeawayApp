class AddGeocoordinatesToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :latitude, :float
  end
end
