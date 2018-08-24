Rails.application.routes.draw do
  resources :users
  resources :restaurants
  resources :dishes

  get "/signup", to: 'users#new', as: 'signup'
  get "/login",     to: 'sessions#new',     as: 'login'
  post "/sessions", to: "sessions#create",  as: 'sessions'
  post "/logout",   to: "sessions#destroy", as: 'logout'
  get '/users/:id/save_dish', to: "users#save_dish", as: 'save_dish'
  get '/users/:id/save_restaurant', to: "users#save_restaurant", as: 'save_restaurant'
  get "/mytakeaways", to: 'static#mytakeaways', as: 'mytakeaways'
    get "/dishes_regional", to: 'dishes#regional', as: 'regional'
  patch "/dish_rating/:id", to: "dishes#add_rating", as: "dishes_rating"
  patch "/restaurant_rating/:id", to: "restaurants#add_rating", as: "restaurants_rating"
  root :to => 'static#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
