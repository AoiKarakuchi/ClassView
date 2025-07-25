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

ActiveRecord::Schema[8.0].define(version: 2025_07_09_041022) do
  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_classrooms_on_name", unique: true
  end

  create_table "memos", force: :cascade do |t|
    t.text "content"
    t.string "user_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_email", "created_at"], name: "index_memos_on_user_email_and_created_at"
  end

  create_table "subject_held_classrooms", force: :cascade do |t|
    t.string "subject_number", null: false
    t.string "classroom_name"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subject_open_timetables", force: :cascade do |t|
    t.string "subject_number", null: false
    t.integer "timetable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["timetable_id"], name: "index_subject_open_timetables_on_timetable_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "number", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_subjects_on_number", unique: true
  end

  create_table "timetables", force: :cascade do |t|
    t.string "semester"
    t.string "dayofweek"
    t.string "hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "note"
  end

  create_table "user_regist_subjects", force: :cascade do |t|
    t.string "user_email", null: false
    t.string "subject_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["user_email", "subject_number"], name: "index_user_regist_subjects_on_user_email_and_subject_number", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "subject_held_classrooms", "classrooms", column: "classroom_name", primary_key: "name"
  add_foreign_key "subject_open_timetables", "subjects", column: "subject_number", primary_key: "number"
  add_foreign_key "subject_open_timetables", "timetables"
  add_foreign_key "user_regist_subjects", "subjects", column: "subject_number", primary_key: "number"
  add_foreign_key "user_regist_subjects", "users", column: "user_email", primary_key: "email"
end
