class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string   "name"
      t.integer  "classification"
      t.string   "address1"
      t.string   "address2"
      t.string   "zip_code"
      t.string   "phone"
      t.integer  "capacity"
      t.decimal  "rating",                    default: 0.0, precision: 15, scale: 2
      t.boolean  "published",                 default: false
      t.datetime "published_until"
      t.text     "special_note"
      t.text     "organization_description"
      t.text     "space_description"
      t.string   "website"

      # Pricing
      t.integer  "price_hour"
      t.integer  "price_daily"
      t.integer  "price_buyout"

      # Amenities
      t.boolean  "wifi",                      default: false
      t.boolean  "audio_visual",              default: false
      t.boolean  "projector",                 default: false
      t.boolean  "white_board",               default: false
      t.boolean  "table_chair",               default: false
      t.boolean  "parking",                   default: false
      t.boolean  "phone_number",              default: false
      t.boolean  "kitchen",                   default: false
      t.boolean  "catering",                  default: false

      # Availability
      t.integer   "weekdays_avaiability_from"
      t.integer   "weekdays_avaiability_to"
      t.integer   "weekend_avaiability_from"
      t.integer   "weekend_avaiability_to"
      t.integer   "minimum_number_of_hours"

      # Open days
      t.boolean   "monday",                   default: false
      t.boolean   "tuesday",                  default: false
      t.boolean   "wednesday",                default: false
      t.boolean   "thursday",                 default: false
      t.boolean   "friday",                   default: false
      t.boolean   "saturday",                 default: false
      t.boolean   "sunday",                   default: false

      t.references :user,                     index: true, foreign_key: true
      t.references :city,                     index: true, foreign_key: true

      t.timestamps null: false

    end
  end
end

