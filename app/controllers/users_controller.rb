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
      the_dish = @user.dishes.find(@dish.id)
      @user.dishes.delete(the_dish)
    else
      @user.dishes << @dish
      @user.save
    end
    redirect_to dish_path(@dish)
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :postcode)
  end
end
