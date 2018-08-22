class DishesController < ApplicationController

  def index
    @dishes = Dish.all
  end

  def show
    @dish = Dish.find(params[:id])
    @query = @dish.name
  end

  def new
    @dish = Dish.new
  end

  def create
    byebug
    @dish = Dish.create(dish_params(:name, :description, :region, :rating, :image_url, :photo_1, :photo_2, :photo_3))

    redirect_to dish_path(@dish)
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def update
    @dish = Dish.find(params[:id])
    @dish.update(dish_params(:name, :description, :region, :rating, :image_url, :photo_1, :photo_2, :photo_3))
    redirect_to dish_path(@dish)
  end

  def destroy
    Dish.find(params[:id]).destroy
    redirect_to dish_path(@dish)
  end

  private

  def dish_params(*args)
    params.require(:dish).permit(*args)
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
