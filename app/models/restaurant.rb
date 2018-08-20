class Restaurant < ApplicationRecord
  has_many :dishes, through: :restaurants_dishes
  has_many :users, through: :users_restaurants
end
