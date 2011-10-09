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

ActiveRecord::Schema.define(:version => 20111004090340) do

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

  create_table "areas", :force => true do |t|
    t.string   "title"
    t.integer  "pensions_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facilities", :force => true do |t|
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

  create_table "price_ranges", :force => true do |t|
    t.integer  "min"
    t.integer  "max"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spot_pensions", :force => true do |t|
    t.integer  "spot_id"
    t.integer  "pension_id"
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
    t.integer  "area_id"
    t.integer  "sub_area_id"
    t.string   "title"
    t.string   "addr"
    t.string   "phone"
    t.text     "description"
    t.string   "url"
    t.boolean  "is_main",        :default => false
    t.boolean  "is_season",      :default => false
    t.integer  "pensions_count", :default => 0
    t.integer  "reviews_count",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_areas", :force => true do |t|
    t.integer  "area_id"
    t.string   "title"
    t.boolean  "is_main",        :default => false
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
    t.string   "email",            :null => false
    t.string   "username"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
