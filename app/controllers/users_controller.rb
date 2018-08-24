class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to @user
    else
      redirect_to new_user_path
    end
  end

  def show
    authorized?
    @user = User.find(params[:id])
  end

  def edit
  authorized_for(params[:id])
  is_admin?
  @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to @user
  end

  def destroy
    is_admin?
  end

  def save_dish
    @user = current_user
    @dish = Dish.find(params[:id])
    if @user.dishes.include?(@dish)
      the_dish_rating = @user.dishes_ratings.find_by(dish_id: @dish.id)
      @user.dishes_ratings.destroy(the_dish_rating)
      @user.dishes_ratings.save
    else
      new_rating = DishesRating.find_or_create_by(user_id: @user.id, dish_id: @dish.id)
      new_rating.save
    end
    redirect_to dish_path(@dish)
  end

  def save_restaurant
    @user = current_user
    @restaurant = Restaurant.find(params[:id])
    if @user.restaurants.include?(@restaurant)
      the_res_rating = @user.restaurants_ratings.find_by(restaurant_id: @restaurant.id)
      @user.restaurants_ratings.destroy(the_res_rating)
      @user.restaurants_ratings.save
    else
      new_rating = RestaurantsRating.find_or_create_by(user_id: @user.id, restaurant_id: @restaurant.id)
      new_rating.save
    end
    redirect_to restaurant_path(@restaurant)
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :postcode)
  end
end
