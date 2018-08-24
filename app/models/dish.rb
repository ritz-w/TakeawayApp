class Dish < ApplicationRecord
  has_and_belongs_to_many :restaurants
  has_many :dishes_ratings
  has_many :users, through: :dishes_ratings


  def self.top_three
    DishesRating.all.order("rating desc").limit(3).map {|rating| rating.dish}
  end

  def saves
    DishesRating.all.select{ |dish| dish.dish_id == self.id}.count
  end

  def average_rating
    ratings = DishesRating.all.select{ |dish_rating| dish_rating.dish_id == self.id}.map {|rating| rating.rating}.compact
    if ratings.count > 0
      ratings.inject(:+)/ratings.count
    else
      return 0
    end
  end

  def get_coordinates_of_region
    chinese_region = self.region
    result = Geocoder.search(chinese_region)
    result.first.coordinates
  end

  def save_dish
  end
end
