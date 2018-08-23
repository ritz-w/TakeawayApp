class Dish < ApplicationRecord
  has_and_belongs_to_many :restaurants
  has_and_belongs_to_many :users

  def self.top_three
    Dish.all.order("rating desc").limit(3)
  end

  def save_dish
  end
end
