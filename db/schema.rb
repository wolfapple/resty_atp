# -*- encoding : utf-8 -*-
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110925075055) do

  create_table "area_spots", :force => true do |t|
    t.integer  "area_id"
    t.integer  "sub_area_id"
    t.integer  "spot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "area_spots", ["area_id"], :name => "index_area_spots_on_area_id"
  add_index "area_spots", ["spot_id"], :name => "index_area_spots_on_spot_id"
  add_index "area_spots", ["sub_area_id"], :name => "index_area_spots_on_sub_area_id"

  create_table "areas", :force => true do |t|
    t.string   "title"
    t.integer  "pensions_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "must_visits", :force => true do |t|
    t.integer  "pension_id"
    t.string   "title"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "must_visits", ["pension_id"], :name => "index_must_visits_on_pension_id"

  create_table "pension_reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pension_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pension_reviews", ["pension_id"], :name => "index_pension_reviews_on_pension_id"
  add_index "pension_reviews", ["user_id"], :name => "index_pension_reviews_on_user_id"

  create_table "pensions", :force => true do |t|
    t.integer  "area_id"
    t.integer  "sub_area_id"
    t.string   "title"
    t.string   "url"
    t.string   "addr"
    t.string   "mobile"
    t.string   "phone"
    t.string   "phone2"
    t.string   "email"
    t.string   "manager"
    t.integer  "rating"
    t.string   "summary"
    t.string   "rooms_count"
    t.string   "room_structure"
    t.integer  "min_price"
    t.integer  "max_price"
    t.string   "season_info"
    t.string   "checkin"
    t.boolean  "service_charge"
    t.boolean  "tax_include"
    t.string   "lat"
    t.string   "lng"
    t.string   "credit_card"
    t.string   "pet"
    t.string   "breakfast"
    t.string   "foreign_language"
    t.string   "pickup"
    t.string   "parking"
    t.string   "facilities"
    t.string   "facilities2"
    t.string   "foodcourt"
    t.string   "baby"
    t.integer  "like_count"
    t.integer  "reviews_count",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pensions", ["area_id"], :name => "index_pensions_on_area_id"
  add_index "pensions", ["sub_area_id"], :name => "index_pensions_on_sub_area_id"

  create_table "rooms", :force => true do |t|
    t.integer  "pension_id"
    t.string   "title"
    t.string   "type"
    t.string   "area"
    t.string   "price"
    t.string   "additional_price"
    t.string   "facilities"
    t.string   "facilities2"
    t.string   "number"
    t.string   "desc"
    t.string   "desc2"
    t.string   "season_info"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rooms", ["pension_id"], :name => "index_rooms_on_pension_id"

  create_table "spot_pensions", :force => true do |t|
    t.integer  "spot_id"
    t.integer  "pension_id"
    t.integer  "reviews_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spot_pensions", ["pension_id"], :name => "index_spot_pensions_on_pension_id"
  add_index "spot_pensions", ["spot_id"], :name => "index_spot_pensions_on_spot_id"

  create_table "spot_reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "spot_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spot_reviews", ["spot_id"], :name => "index_spot_reviews_on_spot_id"
  add_index "spot_reviews", ["user_id"], :name => "index_spot_reviews_on_user_id"

  create_table "spots", :force => true do |t|
    t.string   "title"
    t.text     "desc"
    t.integer  "lat"
    t.integer  "lng"
    t.integer  "pensions_count", :default => 0
    t.integer  "reviews_count",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_areas", :force => true do |t|
    t.integer  "area_id"
    t.string   "title"
    t.integer  "pensions_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_areas", ["area_id"], :name => "index_sub_areas_on_area_id"

  create_table "theme_pensions", :force => true do |t|
    t.integer  "theme_id"
    t.integer  "pension_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "theme_pensions", ["pension_id"], :name => "index_theme_pensions_on_pension_id"
  add_index "theme_pensions", ["theme_id"], :name => "index_theme_pensions_on_theme_id"

  create_table "themes", :force => true do |t|
    t.string   "title"
    t.string   "img"
    t.integer  "pensions_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_providers", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                           :null => false
    t.string   "username"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
