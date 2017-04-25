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

ActiveRecord::Schema.define(version: 20170425193353) do

  create_table "approveds", force: :cascade do |t|
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_movies", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "movie_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "infos", force: :cascade do |t|
    t.string   "street"
    t.string   "email"
    t.string   "phone"
    t.string   "city"
    t.string   "zip_code"
    t.string   "description"
    t.string   "google_url"
    t.string   "cinema_name"
    t.string   "building_number"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "start_mon"
    t.datetime "start_tue"
    t.datetime "start_wed"
    t.datetime "start_thu"
    t.datetime "start_fri"
    t.datetime "start_sat"
    t.datetime "start_sun"
    t.datetime "end_mon"
    t.datetime "end_tue"
    t.datetime "end_wed"
    t.datetime "end_thu"
    t.datetime "end_fri"
    t.datetime "end_sat"
    t.datetime "end_sun"
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.integer  "duration"
    t.integer  "pegi"
    t.string   "description"
    t.string   "director"
    t.string   "actors"
    t.string   "country"
    t.string   "language"
    t.datetime "premiere"
    t.string   "url_trailer"
    t.string   "picture"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "friendly_url"
  end

  create_table "order_seatings", force: :cascade do |t|
    t.integer  "seating_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_tickets", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "phone"
    t.integer  "seance_id"
    t.boolean  "paid"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "approved"
    t.boolean  "paypal"
    t.boolean  "reserved"
    t.string   "list_seats"
    t.string   "activation_code"
  end

  create_table "regulations", force: :cascade do |t|
    t.text     "regulations"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "rows"
    t.integer  "columns"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seances", force: :cascade do |t|
    t.datetime "start_date"
    t.integer  "movie_id"
    t.integer  "room_id"
    t.boolean  "threed"
    t.boolean  "lector"
    t.boolean  "subtitle"
    t.boolean  "dubbing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "block"
    t.index ["start_date"], name: "index_seances_on_start_date"
  end

  create_table "seatings", force: :cascade do |t|
    t.boolean  "slot"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role"
    t.string   "name"
    t.string   "last_name"
    t.string   "phone"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
