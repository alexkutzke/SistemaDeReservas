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

ActiveRecord::Schema.define(version: 20170915001216) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.string   "code"
    t.string   "place"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "disciplines", force: :cascade do |t|
    t.string   "name"
    t.string   "discipline_code"
    t.integer  "department_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["department_id"], name: "index_disciplines_on_department_id"
  end

  create_table "equipment", force: :cascade do |t|
    t.string   "name"
    t.string   "patrimony"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_equipment_on_room_id"
  end

  create_table "materiels", force: :cascade do |t|
    t.string   "name"
    t.string   "patrimony"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_materiels_on_room_id"
  end

  create_table "periods", force: :cascade do |t|
    t.string   "name"
    t.boolean  "state"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "capacity"
    t.string   "room"
    t.string   "building"
    t.boolean  "state"
    t.string   "description"
    t.string   "responsible_person"
    t.integer  "category_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["category_id"], name: "index_rooms_on_category_id"
  end

  create_table "student_classes", force: :cascade do |t|
    t.string   "name"
    t.integer  "period_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["period_id"], name: "index_student_classes_on_period_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
