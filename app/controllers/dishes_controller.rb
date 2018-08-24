class DishesController < ApplicationController

  def index
    @dishes = Dish.all
  end

  def show
    @dish = Dish.find(params[:id])
    @query = @dish.name
    @rating = DishesRating.find_by(user_id: current_user.id, dish_id: @dish.id)
    @restaurants_with_dish = Restaurant.all.select {|restaurant| restaurant.dishes.include?(@dish)}
  end

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.create(dish_params(:name, :description, :region, :rating, :image_url, :photo_1, :photo_2, :photo_3))
    redirect_to dish_path(@dish)
  end

  def add_rating
    rating = DishesRating.find(params[:id])
    rating.update(rating: params["score"])
    redirect_to dish_path(rating.dish)
  end

  def regional
    @dishes = Dish.all
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def update
    @dish = Dish.find(params[:id])
    @dish.update(dish_params)
    redirect_to dish_path(@dish)
  end

  def destroy
    Dish.find(params[:id]).destroy
    redirect_to dishes_path
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :description, :region, :photo_1, :photo_2, :photo_3, restaurant_ids: [])
  end

end

# create_table "dishes", force: :cascade do |t|
#   t.string "name"
#   t.string "description"
#   t.string "region"
#   t.integer "rating"
#   t.string "photo_1"
#   t.string "photo_2"
#   t.string "photo_3"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
