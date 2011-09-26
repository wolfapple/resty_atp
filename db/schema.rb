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

ActiveRecord::Schema.define(:version => 20110926164625) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

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

  create_table "pensionchamber", :force => true do |t|
    t.integer "pensiondataid",                   :null => false
    t.string  "name",            :limit => 200,  :null => false
    t.string  "type",            :limit => 200
    t.string  "area",            :limit => 1000
    t.string  "price",           :limit => 1000
    t.string  "priceadditional", :limit => 1000
    t.string  "facilities01",    :limit => 1000
    t.string  "facilities02",    :limit => 1000
    t.string  "number",          :limit => 200
    t.string  "description01",   :limit => 1000
    t.string  "description02",   :limit => 1000
    t.string  "seasoninfo",      :limit => 1000
    t.string  "imageurl",        :limit => 1000
  end

  create_table "pensiondata", :force => true do |t|
    t.integer   "pensionsetid",                    :null => false
    t.string    "crawlertype",     :limit => 100,  :null => false
    t.timestamp "regdate",                         :null => false
    t.string    "name",            :limit => 1000, :null => false
    t.string    "url",             :limit => 1000, :null => false
    t.string    "address01",       :limit => 1000
    t.string    "address02",       :limit => 1000
    t.string    "mobile",          :limit => 200
    t.string    "telephone01",     :limit => 200
    t.string    "telephone02",     :limit => 200
    t.string    "email",           :limit => 200
    t.string    "manager",         :limit => 200
    t.string    "evaluation",      :limit => 200
    t.string    "summary",         :limit => 2000
    t.string    "roomcount",       :limit => 1000
    t.string    "roomstructure",   :limit => 1000
    t.string    "roomprice",       :limit => 4000
    t.string    "seasoninfo",      :limit => 2000
    t.string    "checkinout",      :limit => 200
    t.string    "servicecharge",   :limit => 200
    t.string    "includetax",      :limit => 200
    t.string    "location",        :limit => 200
    t.string    "locationx",       :limit => 200
    t.string    "locationy",       :limit => 200
    t.string    "locationextra",   :limit => 1000
    t.string    "creditcard",      :limit => 200
    t.string    "pet",             :limit => 200
    t.string    "breakfast",       :limit => 200
    t.string    "foreignlanguage", :limit => 200
    t.string    "pickupservice",   :limit => 200
    t.string    "parking",         :limit => 200
    t.string    "facilities01",    :limit => 1000
    t.string    "facilities02",    :limit => 1000
    t.string    "foodcourt",       :limit => 200
    t.string    "babycarriage",    :limit => 200
  end

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
    t.string   "service_charge"
    t.string   "tax_include"
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
