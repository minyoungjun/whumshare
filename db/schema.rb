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

ActiveRecord::Schema.define(:version => 20130722022255) do

  create_table "address_zips", :force => true do |t|
    t.string   "code"
    t.string   "zip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "banks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "buskets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "uplevel_id",   :default => "0"
    t.string   "uplevel_list"
    t.string   "name"
    t.integer  "count"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "chats", :force => true do |t|
    t.string   "room_number"
    t.string   "seller_id"
    t.string   "buyer_id"
    t.string   "medi_id"
    t.integer  "last_msg_id"
    t.integer  "seller_see_msg_id"
    t.integer  "buyer_see_msg_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "evaluations", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "is_good"
    t.boolean  "is_seller"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "my_searches", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "place"
    t.string   "name"
    t.integer  "method"
    t.integer  "min_price"
    t.integer  "max_price"
    t.integer  "buy_min_year"
    t.integer  "buy_max_year"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "options", :force => true do |t|
    t.string   "type_name"
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "price"
    t.integer  "method"
    t.string   "place"
    t.integer  "category_id"
    t.integer  "buy_year"
    t.integer  "buy_month"
    t.text     "comment"
    t.boolean  "on_timeline"
    t.integer  "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "age"
    t.boolean  "is_girl"
    t.string   "thumb_img"
    t.boolean  "maintain_login"
    t.string   "account_bank"
    t.string   "account_number"
    t.string   "address_zip_code"
    t.string   "address_detail"
    t.string   "phone_number"
    t.string   "home_number"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
