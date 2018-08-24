class Restaurant < ApplicationRecord
  has_and_belongs_to_many :dishes
  has_many :restaurants_ratings
  has_many :users, through: :restaurants_ratings


    def get_address
      if self.address != nil
      "#{self.address + " " + self.postcode}"
      else
      self.postcode
      end
    end

    def self.top_three
      RestaurantsRating.all.order("rating desc").limit(3).map {|rating| rating.restaurant}
    end

    def get_coordinates
      url = "https://api.postcodes.io/postcodes/" + self.postcode.gsub(/\s+/, "").downcase
      response = HTTParty.get(url).parsed_response
      result = []
      result << response["result"]["latitude"]
      result << response["result"]["longitude"]
      result
    end

    def saves
      RestaurantsRating.all.select{ |restaurant| restaurant.restaurant_id == self.id}.count
    end

    def average_rating
      ratings = RestaurantsRating.all.select{ |restaurant_rating| restaurant_rating.restaurant_id == self.id}.map {|rating| rating.rating}.compact
      if ratings.count > 0
        ratings.inject(:+)/ratings.count
      else
        return 0
      end
    end

    def check_number
      self.number.to_f
    end

    def proximity_to_user(current_user)
      url = "https://api.postcodes.io/postcodes/" + self.postcode.gsub(/\s+/, "").downcase
      response = HTTParty.get(url).parsed_response
      restaurant_coordinates = []
      restaurant_coordinates << response["result"]["latitude"]
      restaurant_coordinates << response["result"]["longitude"]
      user_coordinates = current_user.get_coordinates
      distance = Geocoder::Calculations.distance_between(restaurant_coordinates, user_coordinates)
      distance
    end
end
