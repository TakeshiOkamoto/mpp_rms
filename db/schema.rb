# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_09_065700) do

  create_table "rms_clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "tel"
    t.string "email"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.text "info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_rms_clients_on_name", unique: true
  end

  create_table "rms_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "title", null: false
    t.integer "types", null: false
    t.integer "yyyy", null: false
    t.integer "mm", null: false
    t.integer "dd", null: false
    t.integer "day_times", null: false
    t.integer "sales", default: 0
    t.integer "expense1", default: 0
    t.integer "expense2", default: 0
    t.integer "expense3", default: 0
    t.integer "expense4", default: 0
    t.integer "expense5", default: 0
    t.integer "expense6", default: 0
    t.integer "expense7", default: 0
    t.integer "expense8", default: 0
    t.integer "expense9", default: 0
    t.integer "expense10", default: 0
    t.text "content"
    t.text "remarks"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_rms_requests_on_client_id"
    t.index ["mm"], name: "index_rms_requests_on_mm"
    t.index ["title"], name: "index_rms_requests_on_title"
    t.index ["types"], name: "index_rms_requests_on_types"
    t.index ["yyyy", "mm"], name: "index_rms_requests_on_yyyy_and_mm"
    t.index ["yyyy"], name: "index_rms_requests_on_yyyy"
  end

  create_table "rms_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "password_digest", null: false
    t.boolean "admin", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
