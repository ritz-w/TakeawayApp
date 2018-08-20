class User < ApplicationRecord
  has_many :restaurants, through: :users_restaurants
  has_many :dishes, through: :users_dishes
end
