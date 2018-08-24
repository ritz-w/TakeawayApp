require 'httparty'


class User < ApplicationRecord
  include HTTParty
  has_many :restaurants_ratings
  has_many :dishes_ratings
  has_many :restaurants, through: :restaurants_ratings
  has_many :dishes, through: :dishes_ratings
  validates :username, uniqueness: true, presence: true
  has_secure_password

  def get_coordinates
    url = "https://api.postcodes.io/postcodes/" + self.postcode.gsub(/\s+/, "").downcase
    response = HTTParty.get(url).parsed_response
    result = []
    result << response["result"]["latitude"]
    result << response["result"]["longitude"]
    result
  end

  def nearest_restaurants
     results = Restaurant.all.sort_by{|restaurant| restaurant.proximity_to_user(self)}
     results[0..2]
  end

end
