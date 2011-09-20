# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20110920033752) do

  create_table "must_visits", :force => true do |t|
    t.integer  "pension_id"
    t.string   "title"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "must_visits", ["pension_id"], :name => "index_must_visits_on_pension_id"

  create_table "pension_reviews", :force => true do |t|
    t.integer  "pension_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pension_reviews", ["pension_id"], :name => "index_pension_reviews_on_pension_id"

  create_table "pensions", :force => true do |t|
    t.string   "title"
    t.string   "addr1"
    t.string   "addr2"
    t.string   "addr"
    t.string   "phone"
    t.string   "lat"
    t.string   "lng"
    t.integer  "min_price"
    t.integer  "max_price"
    t.integer  "like_count"
    t.integer  "reviews_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.integer  "pension_id"
    t.string   "title"
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
    t.integer  "spot_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spot_reviews", ["spot_id"], :name => "index_spot_reviews_on_spot_id"

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
