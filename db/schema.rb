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

ActiveRecord::Schema.define(version: 20161129004933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "active",      default: false
    t.string   "description"
  end

  create_table "charities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "logo"
    t.boolean  "featured",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: false
    t.integer  "state_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.integer  "coupon_type"
    t.decimal  "discount",    precision: 15, scale: 2, default: 0.0
    t.string   "code"
    t.integer  "plan_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "coupons", ["plan_id"], name: "index_coupons_on_plan_id", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.integer  "number_of_publications"
    t.decimal  "price",                  precision: 15, scale: 2, default: 0.0
    t.integer  "duration_in_days",                                default: 0
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.text     "additional_info"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "stars",      default: 0
    t.integer  "space_id"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "ratings", ["space_id"], name: "index_ratings_on_space_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

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
    t.integer  "subscription_id"
  end

  add_index "spaces", ["city_id"], name: "index_spaces_on_city_id", using: :btree
  add_index "spaces", ["subscription_id"], name: "index_spaces_on_subscription_id", using: :btree
  add_index "spaces", ["user_id"], name: "index_spaces_on_user_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "valid_through"
    t.integer  "plan_id"
    t.integer  "coupon_id"
    t.integer  "user_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "stripe_charge_id"
    t.decimal  "amount_paid",            precision: 15, scale: 2
    t.integer  "available_publications"
  end

  add_index "subscriptions", ["coupon_id"], name: "index_subscriptions_on_coupon_id", using: :btree
  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

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
  add_foreign_key "coupons", "plans"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "ratings", "spaces"
  add_foreign_key "ratings", "users"
  add_foreign_key "space_categories", "categories"
  add_foreign_key "space_categories", "spaces"
  add_foreign_key "space_pictures", "spaces"
  add_foreign_key "spaces", "cities"
  add_foreign_key "spaces", "subscriptions"
  add_foreign_key "spaces", "users"
  add_foreign_key "subscriptions", "coupons"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
end
