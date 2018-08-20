class Dish < ApplicationRecord
  has_many :restaurants, through: :restaurants_dishes
  has_many :users, through: :users_dishes
end
