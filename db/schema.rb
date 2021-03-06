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

ActiveRecord::Schema.define(version: 20171113212210) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classrooms", force: :cascade do |t|
    t.integer  "capacity"
    t.string   "room"
    t.string   "building"
    t.boolean  "state"
    t.string   "description"
    t.string   "responsible_person"
    t.integer  "category_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["category_id"], name: "index_classrooms_on_category_id"
    t.index ["room"], name: "index_classrooms_on_room", unique: true
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.string   "code"
    t.integer  "sector_id",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["sector_id"], name: "index_departments_on_sector_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string   "name"
    t.string   "discipline_code"
    t.integer  "department_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["department_id"], name: "index_disciplines_on_department_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start",                        null: false
    t.datetime "end",                          null: false
    t.boolean  "reservation",   default: true
    t.string   "title"
    t.string   "255"
    t.integer  "frequency",     default: 1
    t.integer  "state",         default: 1
    t.integer  "klass_id"
    t.integer  "discipline_id"
    t.integer  "classroom_id"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["classroom_id"], name: "index_events_on_classroom_id"
    t.index ["discipline_id"], name: "index_events_on_discipline_id"
    t.index ["klass_id"], name: "index_events_on_klass_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "klasses", force: :cascade do |t|
    t.string   "name"
    t.integer  "period_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["period_id"], name: "index_klasses_on_period_id"
  end

  create_table "materiels", force: :cascade do |t|
    t.string   "name"
    t.string   "patrimony"
    t.string   "serial_number"
    t.integer  "classroom_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["classroom_id"], name: "index_materiels_on_classroom_id"
  end

  create_table "periods", force: :cascade do |t|
    t.string   "name"
    t.boolean  "state"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.boolean  "index",      default: false
    t.boolean  "new",        default: false
    t.boolean  "edit",       default: false
    t.boolean  "remove",     default: false
    t.boolean  "import",     default: false
    t.integer  "session",    default: 0
    t.integer  "role_id",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["role_id"], name: "index_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "end",                               null: false
    t.datetime "start",                             null: false
    t.integer  "frequency",     default: 1
    t.string   "color",         default: "#c3302c"
    t.integer  "state",         default: 1
    t.boolean  "reservation",   default: true
    t.string   "title"
    t.integer  "klass_id"
    t.integer  "discipline_id"
    t.integer  "classroom_id"
    t.integer  "user_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["classroom_id"], name: "index_schedules_on_classroom_id"
    t.index ["discipline_id"], name: "index_schedules_on_discipline_id"
    t.index ["klass_id"], name: "index_schedules_on_klass_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "name",                                           null: false
    t.string   "cpf",                    limit: 11,              null: false
    t.string   "phone_number",           limit: 11
    t.string   "registration_number",                            null: false
    t.integer  "role_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

end
