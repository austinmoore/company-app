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

ActiveRecord::Schema.define(version: 20180304135553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "identity", null: false
    t.index ["identity"], name: "index_companies_on_identity", unique: true
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.text "first_name", null: false
    t.text "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "identifier", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["identifier"], name: "index_employees_on_identifier", unique: true
  end

  add_foreign_key "employees", "companies"
end
