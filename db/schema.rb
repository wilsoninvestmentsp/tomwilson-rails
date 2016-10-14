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

ActiveRecord::Schema.define(version: 20160901195343) do

  create_table "charts", force: :cascade do |t|
    t.integer  "property_id", limit: 4
    t.string   "title",       limit: 255
    t.decimal  "value",                   precision: 15, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "contents", ["key"], name: "index_contents_on_key", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "property_id", limit: 4
    t.string   "image",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "images", ["property_id"], name: "index_images_on_property_id", using: :btree

  create_table "jassets", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.string   "link_name",   limit: 255
    t.string   "link_uri",    limit: 255
    t.integer  "sort",        limit: 4
    t.string   "image",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "type",       limit: 255
    t.string   "name",       limit: 255
    t.string   "status",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "links", force: :cascade do |t|
    t.integer  "property_id", limit: 4
    t.string   "title",       limit: 255
    t.string   "link",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string   "title",                   limit: 255
    t.string   "slug",                    limit: 255
    t.text     "description",             limit: 65535
    t.integer  "featured",                limit: 4
    t.string   "building_type",           limit: 255
    t.string   "address",                 limit: 255
    t.string   "city",                    limit: 255
    t.string   "state",                   limit: 255
    t.string   "zip",                     limit: 255
    t.integer  "year_built",              limit: 4
    t.integer  "square_ft",               limit: 4
    t.decimal  "offer_price",                           precision: 15, scale: 2
    t.string   "status",                  limit: 255
    t.string   "leased",                  limit: 255,                            default: "no"
    t.decimal  "bedrooms",                              precision: 15, scale: 2
    t.decimal  "bathrooms",                             precision: 15, scale: 2
    t.decimal  "garages",                               precision: 15, scale: 2
    t.decimal  "carports",                              precision: 15, scale: 2
    t.decimal  "monthly_return",                        precision: 15, scale: 2
    t.datetime "created_at",                                                                     null: false
    t.datetime "updated_at",                                                                     null: false
    t.string   "images",                  limit: 255
    t.string   "highlight",               limit: 255
    t.string   "offer_price_label",       limit: 255
    t.decimal  "cash_flow",                             precision: 15, scale: 2
    t.integer  "lot_size",                limit: 4
    t.string   "school_district",         limit: 255
    t.boolean  "active",                                                         default: false
    t.decimal  "rent",                                  precision: 15, scale: 2
    t.decimal  "property_management_fee",               precision: 15, scale: 2
    t.decimal  "mortgage_payment",                      precision: 15, scale: 2
    t.decimal  "hoa_fee",                               precision: 15, scale: 2
    t.decimal  "property_tax",                          precision: 15, scale: 2
    t.decimal  "hazard_insurance",                      precision: 15, scale: 2
    t.string   "image",                   limit: 255
  end

  add_index "properties", ["slug"], name: "index_properties_on_slug", unique: true, using: :btree

  create_table "requests", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "code",       limit: 4
    t.string   "status",     limit: 255
    t.text     "data",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "testimonies", force: :cascade do |t|
    t.text     "quote",      limit: 65535
    t.string   "author",     limit: 255
    t.integer  "sort",       limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "sort",            limit: 4,     default: 0
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "role",            limit: 255
    t.string   "phone",           limit: 255
    t.string   "image",           limit: 255
    t.text     "description",     limit: 65535
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.boolean  "admin",                         default: false
    t.boolean  "public",                        default: true
    t.string   "team",            limit: 255,   default: "california"
  end

end
