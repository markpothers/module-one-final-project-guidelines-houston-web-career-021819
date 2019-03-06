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

ActiveRecord::Schema.define(version: 20190306160929) do

  create_table "cities", force: :cascade do |t|
    t.text "name"
  end

  create_table "deals", force: :cascade do |t|
    t.integer "service_id"
    t.integer "city_id"
    t.text    "name"
    t.text    "description"
    t.integer "merchant_id"
    t.integer "list_price"
    t.integer "deal_price"
    t.float   "discount"
    t.text    "url"
    t.text    "address"
    t.text    "phone"
  end

  create_table "merchants", force: :cascade do |t|
    t.text "name"
  end

  create_table "services", force: :cascade do |t|
    t.text "service"
  end

end
