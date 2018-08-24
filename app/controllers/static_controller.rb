require 'net/http'
require 'json'

class StaticController < ApplicationController

  def index
  end

  def mytakeaways
    if !logged_in?
      flash[:authorized] = "Sorry! You must login to access the closest takeaways feature."
      redirect_to restaurants_path
    else
      @nearest_restaurants = current_user.nearest_restaurants
    end
  end

  private

  def geounits
    "#{@postcode["result"]["latitude"]},#{@postcode["result"]["longitude"]}"
  end
end
