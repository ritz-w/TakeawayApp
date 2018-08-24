class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all.select {|r| r.postcode.length > 4}
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @rating = RestaurantsRating.find_by(user_id: current_user.id, restaurant_id: @restaurant.id)
    @address = Geocoder.search(@restaurant.postcode)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)

    redirect_to restaurant_path(@restaurant)
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def add_rating
    rating = RestaurantsRating.find(params[:id])
    rating.update(rating: params["score"])
    redirect_to restaurant_path(rating.restaurant)
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    byebug
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    redirect_to restaurants_path
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:name, :number, :postcode, :phone_number, dish_ids: [])
  end
# To get a strong params to acccept an attribute array, you need to explicitly state it such as 'dish_ids: []'
end
