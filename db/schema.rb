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

ActiveRecord::Schema.define(:version => 20110915111840) do

  create_table "must_visits", :force => true do |t|
    t.integer  "pension_id"
    t.string   "title"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "must_visits", ["pension_id"], :name => "index_must_visits_on_pension_id"

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
    t.integer  "reviews_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pension_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["pension_id"], :name => "index_reviews_on_pension_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "spots", :force => true do |t|
    t.string   "title"
    t.integer  "lat"
    t.integer  "lng"
    t.integer  "pensions_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "themes", :force => true do |t|
    t.string   "title"
    t.string   "img"
    t.integer  "pensions_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
