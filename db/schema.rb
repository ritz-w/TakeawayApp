# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_21_143658) do

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "region"
    t.string "photo_1"
    t.string "photo_2"
    t.string "photo_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "img_url"
  end

  create_table "dishes_ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "dish_id"
    t.integer "rating"
  end

  create_table "dishes_restaurants", id: false, force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "dish_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "postcode"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.text "number"
  end

  create_table "restaurants_ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "restaurant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin"
  end

end
