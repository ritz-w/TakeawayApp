require 'net/http'
require 'json'

class StaticController < ApplicationController

  def index
  end

  def mytakeaways
    @nearest_restaurants = current_user.nearest_restaurants
  end

  private

  def geounits
    "#{@postcode["result"]["latitude"]},#{@postcode["result"]["longitude"]}"
  end
end
