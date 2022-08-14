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

ActiveRecord::Schema.define(version: 2022_08_14_114400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "address", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "nacebel_codes", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "recommendations"
  end

  create_table "simulation_nacebel_codes", force: :cascade do |t|
    t.bigint "simulation_id", null: false
    t.bigint "nacebel_code_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nacebel_code_id"], name: "index_simulation_nacebel_codes_on_nacebel_code_id"
    t.index ["simulation_id"], name: "index_simulation_nacebel_codes_on_simulation_id"
  end

  create_table "simulations", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.integer "annual_revenue"
    t.string "enterprise_number"
    t.string "company_legal_name"
    t.boolean "natural_person", default: false
    t.jsonb "quote", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_simulations_on_contact_id"
  end

  add_foreign_key "simulations", "contacts"
end
