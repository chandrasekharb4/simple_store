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

ActiveRecord::Schema.define(version: 2020_12_17_080809) do

  create_table "boat_drivers", force: :cascade do |t|
    t.integer "boat_id"
    t.string "name"
    t.string "license_numner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "boat_types", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "boats", force: :cascade do |t|
    t.string "name"
    t.integer "control_room_id"
    t.string "name_of_the_vessel"
    t.string "registration_number"
    t.string "owner_of_the_vessel"
    t.string "owner_email"
    t.string "mobile_no"
    t.string "navigation_route"
    t.string "route_permission_number"
    t.string "captain_name"
    t.string "captain_license_no"
    t.integer "created_by"
    t.string "user_id"
    t.integer "life_jackets"
    t.integer "fire_extinguishers"
    t.integer "passenger_capacity"
    t.integer "life_rafts"
    t.integer "life_buoys"
    t.string "trip_duriation"
    t.string "boat_type"
    t.string "engine_type"
    t.string "proposed_use"
    t.boolean "active", default: true
    t.string "permission_file_no"
    t.string "status"
    t.boolean "trip_run", default: false
    t.integer "division_id"
    t.integer "unit_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "control_points", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "district"
    t.string "contact_number"
    t.string "email"
    t.boolean "active", default: true
    t.string "code"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "engine_types", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "file_sequences", force: :cascade do |t|
    t.string "file_type"
    t.integer "sequence_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "noc_boat_registrations", force: :cascade do |t|
    t.string "owner_name"
    t.string "agency_name"
    t.string "owner_email"
    t.string "mobile_number"
    t.text "adress"
    t.string "boat_name"
    t.string "boat_type"
    t.string "engine_type"
    t.string "manufacturing_certificate_number"
    t.string "manufacturing_date"
    t.string "proposed_location"
    t.string "proposed_use"
    t.string "file_no"
    t.integer "user_id"
    t.string "application_status"
    t.date "applied_date"
    t.date "expire_date"
    t.date "approved_date"
    t.string "paid_amount"
    t.string "tnr_no"
    t.string "aadharCard"
    t.string "manufacturing_certificate"
    t.integer "approved_by"
    t.text "comment"
    t.integer "controll_room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "user_id"
    t.string "mobile_number"
    t.float "amount"
    t.string "tnr_no"
    t.string "payment_status"
    t.text "transaction_details"
    t.string "payment_at"
    t.string "email"
    t.string "name"
    t.string "used_file_no"
    t.boolean "is_used", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permission_orders", force: :cascade do |t|
    t.string "control_room_location"
    t.string "name_of_the_vessel"
    t.string "registration_number"
    t.string "owner_of_the_vessel"
    t.string "owner_email"
    t.string "mobile_no"
    t.string "navigation_route"
    t.string "route_permission_number"
    t.string "license_registration_certificate"
    t.string "routes_permisiion"
    t.string "captain_license"
    t.string "noc_certificate"
    t.string "captain_name"
    t.string "captain_license_no"
    t.string "application_status"
    t.date "appllied_date"
    t.integer "approved_by"
    t.date "approved_at"
    t.string "approved_document"
    t.integer "user_id"
    t.string "file_no"
    t.integer "life_jackets"
    t.integer "fire_extinguishers"
    t.integer "passenger_capacity"
    t.integer "life_rafts"
    t.integer "controll_room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "proposed_uses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "system_settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trip_clearances", force: :cascade do |t|
    t.integer "boat_id"
    t.integer "control_room_id"
    t.string "name_of_the_vessel"
    t.string "registration_number"
    t.string "owner_of_the_vessel"
    t.string "owner_email"
    t.string "mobile_no"
    t.string "navigation_route"
    t.string "route_permission_number"
    t.string "captain_name"
    t.string "captain_license_no"
    t.string "created_by"
    t.integer "life_jackets"
    t.integer "fire_extinguishers"
    t.integer "passenger_capacity"
    t.integer "life_rafts"
    t.integer "life_buoys"
    t.integer "trip_duriation"
    t.string "boat_type"
    t.string "engine_type"
    t.string "proposed_use"
    t.boolean "is_current", default: false
    t.date "departure_date"
    t.boolean "wearing_life_jackets", default: false
    t.boolean "influence_of_alcohol", default: false
    t.boolean "trip_end", default: false
    t.string "trip_no"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "remarks"
    t.integer "passenger_count"
    t.string "briefed_to_passenger"
    t.string "overloaded"
    t.string "wearing_life_jackets_all"
    t.string "influence_of_alcohol_all"
    t.string "registered_with_aptdc"
    t.string "has_route_permissions"
    t.string "has_prominently_displays_the_capacity"
    t.string "has_lifesaving_equipment"
    t.string "has_adequate_firefighting_equipment"
    t.string "does_not_have_any_major_damage"
    t.string "has_crew_displayed"
    t.string "driver_has_the_requisite_license_and_is_registered"
    t.string "crew_have_the_requisite_licenses_and_are_registered"
    t.string "boat_driver_and_the_crew_have_their_identity_cards_badges"
    t.string "crew_is_fit_and_healthy_not"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trip_drivers", force: :cascade do |t|
    t.string "name"
    t.string "license_number"
    t.integer "boat_id"
    t.integer "trip_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "division_id"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_sessions", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "mobile_no"
    t.string "email"
    t.string "crypted_password"
    t.string "password_salt"
    t.string "persistence_token"
    t.string "perishable_token"
    t.string "password"
    t.string "password_confirmation"
    t.boolean "super_admin"
    t.boolean "employee"
    t.boolean "employee_code"
    t.string "user_role"
    t.integer "control_room_id"
    t.boolean "unit_user", default: false
    t.boolean "ho_user", default: false
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
