# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_09_03_074743) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.string "street"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "venue_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_offers_on_venue_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.bigint "offer_id", null: false
    t.bigint "venue_admin_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_reservations_on_offer_id"
    t.index ["venue_admin_id"], name: "index_reservations_on_venue_admin_id"
    t.index ["venue_id"], name: "index_reservations_on_venue_id"
  end

  create_table "reservations_variants", id: false, force: :cascade do |t|
    t.bigint "reservation_id", null: false
    t.bigint "variant_id", null: false
    t.index ["reservation_id", "variant_id"], name: "index_reservations_variants_on_reservation_id_and_variant_id", unique: true
    t.index ["reservation_id"], name: "index_reservations_variants_on_reservation_id"
    t.index ["variant_id"], name: "index_reservations_variants_on_variant_id"
  end

  create_table "variants", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.bigint "offer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "period"
    t.index ["offer_id"], name: "index_variants_on_offer_id"
  end

  create_table "venue_admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_name"
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_venue_admins_on_company_id"
    t.index ["email"], name: "index_venue_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_venue_admins_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "venue_admin_id"
    t.index ["venue_admin_id"], name: "index_venues_on_venue_admin_id"
  end

  add_foreign_key "offers", "venues"
  add_foreign_key "reservations", "offers"
  add_foreign_key "reservations", "venue_admins"
  add_foreign_key "reservations", "venues"
  add_foreign_key "variants", "offers"
  add_foreign_key "venue_admins", "companies"
  add_foreign_key "venues", "venue_admins"
end
