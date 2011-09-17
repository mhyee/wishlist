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

ActiveRecord::Schema.define(:version => 20110911205134) do

  create_table "claimlists", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "claimlists", ["user_id"], :name => "index_claimlists_on_user_id"

  create_table "items", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "wantlist_id"
    t.integer  "claimlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["claimlist_id"], :name => "index_items_on_claimlist_id"
  add_index "items", ["wantlist_id"], :name => "index_items_on_wantlist_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wantlists", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wantlists", ["user_id"], :name => "index_wantlists_on_user_id"

end