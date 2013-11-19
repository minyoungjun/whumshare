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

ActiveRecord::Schema.define(:version => 20131119160721) do

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
    t.string   "uplevel_id", :default => "1"
    t.string   "name",                        :null => false
    t.string   "end",        :default => "1"
    t.integer  "count",      :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "chats", :force => true do |t|
    t.string   "room_number"
    t.integer  "product_id"
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.integer  "last_msg_id"
    t.integer  "seller_see_msg_id"
    t.integer  "buyer_see_msg_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "evaluations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "evalutation"
    t.boolean  "is_seller"
    t.text     "comment"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "chat_id"
    t.integer  "user_id"
    t.string   "content"
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

  create_table "notifications", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.integer  "type",       :default => 0,   :null => false
    t.string   "content"
    t.string   "readed",     :default => "0"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
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
    t.integer  "represent_upload_id", :default => 0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "uploads", :force => true do |t|
    t.integer  "product_id",          :default => 0
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "birthday"
    t.integer  "gender",           :default => 0
    t.string   "thumb_img"
    t.integer  "friend_count",     :default => 0
    t.boolean  "maintain_login",   :default => false
    t.string   "account_bank",     :default => ""
    t.string   "account_number",   :default => ""
    t.string   "address_zip_code", :default => ""
    t.string   "address_detail",   :default => ""
    t.string   "phone_number",     :default => ""
    t.string   "home_number",      :default => ""
    t.integer  "good_count",       :default => 0
    t.integer  "bad_count",        :default => 0
    t.integer  "trade_count",      :default => 0
    t.boolean  "now_login",        :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

end
