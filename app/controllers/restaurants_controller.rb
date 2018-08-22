class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @address = Geocoder.search(@restaurant.postcode)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    byebug
    @restaurant = Restaurant.create(restaurant_params)

    redirect_to restaurant_path(@restaurant)
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)

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
