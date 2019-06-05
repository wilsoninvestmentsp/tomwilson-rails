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

ActiveRecord::Schema.define(version: 20190604051754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annual_returns", force: :cascade do |t|
    t.integer  "syndication_id"
    t.integer  "year"
    t.integer  "projected_annual_return"
    t.integer  "actual_annual_return"
    t.integer  "quarter_1"
    t.integer  "quarter_2"
    t.integer  "quarter_3"
    t.integer  "quarter_4"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "annual_returns", ["syndication_id"], name: "index_annual_returns_on_syndication_id", using: :btree

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.text     "summary"
    t.date     "date"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "status",     default: 1
    t.string   "author",     default: ""
  end

  add_index "blogs", ["slug"], name: "index_blogs_on_slug", using: :btree

  create_table "charts", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "title"
    t.decimal  "value",       precision: 15, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string   "key"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contents", ["key"], name: "index_contents_on_key", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
  end

  add_index "images", ["property_id"], name: "index_images_on_property_id", using: :btree

  create_table "jassets", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link_name"
    t.string   "link_uri"
    t.string   "sort"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "job_applications", force: :cascade do |t|
    t.string   "resume"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "current_company"
    t.string   "linkedin_url"
    t.integer  "job_posting_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "job_applications", ["job_posting_id"], name: "index_job_applications_on_job_posting_id", using: :btree

  create_table "job_postings", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "job_status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "job_type"
    t.string   "city"
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "type"
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "title"
    t.string   "link"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "meetup_events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "meetup_image"
    t.boolean  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "url"
  end

  create_table "properties", force: :cascade do |t|
    t.string   "address"
    t.integer  "year_built"
    t.integer  "square_ft"
    t.decimal  "offer_price",             precision: 15, scale: 2
    t.decimal  "rent",                    precision: 15, scale: 2
    t.string   "status"
    t.string   "leased",                                           default: "no"
    t.decimal  "bedrooms",                precision: 15, scale: 2
    t.decimal  "bathrooms",               precision: 15, scale: 2
    t.decimal  "garages",                 precision: 15, scale: 2
    t.decimal  "carports",                precision: 15, scale: 2
    t.decimal  "monthly_return",          precision: 15, scale: 2
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.string   "images"
    t.string   "title"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "slug"
    t.string   "highlight"
    t.string   "offer_price_label"
    t.text     "description"
    t.integer  "featured"
    t.string   "building_type"
    t.decimal  "cash_flow",               precision: 15, scale: 2
    t.integer  "lot_size"
    t.string   "school_district"
    t.boolean  "active",                                           default: false
    t.decimal  "property_management_fee", precision: 15, scale: 2
    t.decimal  "mortgage_payment",        precision: 15, scale: 2
    t.decimal  "hoa_fee",                 precision: 15, scale: 2
    t.decimal  "property_tax",            precision: 15, scale: 2
    t.decimal  "hazard_insurance",        precision: 15, scale: 2
    t.string   "image"
  end

  add_index "properties", ["slug"], name: "index_properties_on_slug", unique: true, using: :btree

  create_table "requests", force: :cascade do |t|
    t.string   "name"
    t.integer  "code"
    t.string   "status"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "syndications", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "purchase_price"
    t.integer  "raise_amount"
    t.string   "hold_period"
    t.string   "preferred_return"
    t.string   "average_annual_return"
    t.string   "irr"
    t.date     "close_date"
    t.integer  "price_per_share"
    t.integer  "loan_amount"
    t.string   "loan_rate"
    t.string   "year_built"
    t.integer  "building_size"
    t.float    "lot_size"
    t.integer  "number_of_buildings"
    t.string   "property_type"
    t.integer  "number_of_tenants"
    t.string   "image"
    t.string   "notes"
    t.boolean  "active",                default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "status"
    t.string   "location"
  end

  add_index "syndications", ["slug"], name: "index_syndications_on_slug", using: :btree

  create_table "testimonies", force: :cascade do |t|
    t.text     "quote"
    t.string   "author"
    t.integer  "sort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
    t.string   "phone"
    t.string   "image"
    t.text     "description"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",           default: false
    t.boolean  "public",          default: true
    t.integer  "sort",            default: 0
    t.string   "team",            default: "california"
  end

  add_foreign_key "job_applications", "job_postings"
end
