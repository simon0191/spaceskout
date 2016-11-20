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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161119234240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "active",      default: false
    t.string   "description"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: false
    t.integer  "state_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "space_categories", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "space_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "space_categories", ["category_id"], name: "index_space_categories_on_category_id", using: :btree
  add_index "space_categories", ["space_id"], name: "index_space_categories_on_space_id", using: :btree

  create_table "space_pictures", force: :cascade do |t|
    t.string   "image"
    t.boolean  "primary",    default: false
    t.integer  "space_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "space_pictures", ["space_id"], name: "index_space_pictures_on_space_id", using: :btree

  create_table "spaces", force: :cascade do |t|
    t.string   "name"
    t.integer  "classification"
    t.string   "address1"
    t.string   "address2"
    t.string   "zip_code"
    t.string   "phone"
    t.integer  "capacity"
    t.decimal  "rating",                     precision: 15, scale: 2, default: 0.0
    t.boolean  "published",                                           default: false
    t.datetime "published_until"
    t.text     "special_note"
    t.text     "organization_description"
    t.text     "description"
    t.string   "website"
    t.integer  "price_hourly"
    t.integer  "price_daily"
    t.integer  "price_buyout"
    t.boolean  "wifi",                                                default: false
    t.boolean  "audio_visual",                                        default: false
    t.boolean  "projector",                                           default: false
    t.boolean  "white_board",                                         default: false
    t.boolean  "table_chair",                                         default: false
    t.boolean  "parking",                                             default: false
    t.boolean  "phone_number",                                        default: false
    t.boolean  "kitchen",                                             default: false
    t.boolean  "catering",                                            default: false
    t.integer  "weekdays_availability_from"
    t.integer  "weekdays_availability_to"
    t.integer  "weekend_availability_from"
    t.integer  "weekend_availability_to"
    t.integer  "minimum_number_of_hours"
    t.boolean  "monday",                                              default: false
    t.boolean  "tuesday",                                             default: false
    t.boolean  "wednesday",                                           default: false
    t.boolean  "thursday",                                            default: false
    t.boolean  "friday",                                              default: false
    t.boolean  "saturday",                                            default: false
    t.boolean  "sunday",                                              default: false
    t.integer  "user_id"
    t.integer  "city_id"
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
  end

  add_index "spaces", ["city_id"], name: "index_spaces_on_city_id", using: :btree
  add_index "spaces", ["user_id"], name: "index_spaces_on_user_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "type"
    t.string   "business_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "avatar"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "cities", "states"
  add_foreign_key "space_categories", "categories"
  add_foreign_key "space_categories", "spaces"
  add_foreign_key "space_pictures", "spaces"
  add_foreign_key "spaces", "cities"
  add_foreign_key "spaces", "users"
end
