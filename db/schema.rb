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

ActiveRecord::Schema.define(version: 20180506101038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alleleans", force: :cascade do |t|
    t.text "name", null: false
    t.text "photo", null: false
    t.integer "evolve_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "multiplier_steps"
    t.float "multiplier_calories"
    t.float "multiplier_sleep"
    t.float "multiplier_water"
    t.text "web_photo"
    t.text "slug"
  end

  create_table "helix_infos", force: :cascade do |t|
    t.text "gene"
    t.text "variant"
    t.text "a1"
    t.text "a2"
    t.text "trait"
    t.text "insight"
    t.text "recommend"
    t.text "impact"
    t.text "frequency"
    t.text "references"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stables", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "allelean_id", null: false
    t.boolean "is_active", default: false
    t.datetime "aquired_date"
    t.integer "exp", default: 0
    t.integer "level", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "name", null: false
    t.text "email"
    t.text "dna"
    t.text "fitbit_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "helix_ids", array: true
    t.integer "daily_steps"
    t.integer "daily_calorie_burn"
    t.integer "daily_distance"
    t.integer "daily_floors"
    t.integer "daily_water_in_cups"
    t.integer "daily_sleep_in_mins"
    t.time "daily_bedtime"
    t.time "daily_wakeuptime"
  end

end
