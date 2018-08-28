class AnalyticsController < ApplicationController

  def index
    query
  end

  def query
    total_users
    total_dishes
    total_restaurants
    user_most_fav_dish
    user_most_pop_region
    user_most_dish_var
  end

  def total_users
      @total_users = User.count
  end

  def total_dishes
    @total_dishes = Dish.count
  end

  def total_restaurants
    @total_restaurants = Restaurant.count
  end

  def user_most_fav_dish
    arranged = users_by_highest_number_of_dishes
    @user_most_fav_dish = arranged.first.name
  end

  def user_most_pop_region

    dish_hash ={}
    region_hash = {}

    all_users.map do |user|
      if user.dishes[0] == []
        else
          dish_hash[user.name] ||= user.dishes.map {|dish| dish.region}
        end
    end


    dish_hash.select! {|key, value| value != [] }
    if dish_hash == {}
      return
    else
    dish_hash.each do |k,v|
      v.each do |value|
          if !!region_hash[value]
            region_hash[value] += 1
          else
            region_hash[value] = 1
          end
        end
      end
    end

    @user_most_pop_region = region_hash.max_by{|k,v| v}[0]
    end
  end

  def user_most_dish_var

    dish_hash ={}
    common_hash = {}
    region_hash = {"Guangdong" => 0, "Sichuan" => 0, "Guangzhou" => 0}

    all_users.map do |user|
      if user.dishes[0] == []
        else
          dish_hash[user.name] ||= user.dishes.map {|dish| dish.region}
        end
    end


    dish_hash.select! {|key, value| value != [] }

    dish_hash.each do |key,value|
      value.each do |region|
      common_hash[key] = region_hash
            end
        end

  end

private

  def all_users
    User.all
  end

  def all_dishes
    Dish.all
  end

  def all_restaurants
    Restaurant.all
  end

  def users_by_highest_number_of_dishes
    all_users.sort_by{|user| user.dishes.length}.reverse
  end
