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

ActiveRecord::Schema.define(version: 2019_10_15_024430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.float "depreciation_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "commontator_comments", force: :cascade do |t|
    t.bigint "thread_id", null: false
    t.string "creator_type", null: false
    t.bigint "creator_id", null: false
    t.string "editor_type"
    t.bigint "editor_id"
    t.text "body", null: false
    t.datetime "deleted_at"
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.index ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down"
    t.index ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up"
    t.index ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id"
    t.index ["editor_type", "editor_id"], name: "index_commontator_comments_on_editor_type_and_editor_id"
    t.index ["parent_id"], name: "index_commontator_comments_on_parent_id"
    t.index ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at"
  end

  create_table "commontator_subscriptions", force: :cascade do |t|
    t.bigint "thread_id", null: false
    t.string "subscriber_type", null: false
    t.bigint "subscriber_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true
    t.index ["thread_id"], name: "index_commontator_subscriptions_on_thread_id"
  end

  create_table "commontator_threads", force: :cascade do |t|
    t.string "commontable_type"
    t.bigint "commontable_id"
    t.string "closer_type"
    t.bigint "closer_id"
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["closer_type", "closer_id"], name: "index_commontator_threads_on_closer_type_and_closer_id"
    t.index ["commontable_type", "commontable_id"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "designation"
    t.string "name"
    t.string "contact_no"
    t.string "address"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["invitation_token"], name: "index_employees_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_employees_on_invitations_count"
    t.index ["invited_by_id"], name: "index_employees_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_employees_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "item_assignments", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "employee_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 1
    t.date "returned_date"
    t.bigint "category_id"
    t.date "assigned_date"
    t.integer "transferred_quantity"
    t.integer "returned_quantity"
    t.date "transferred_date"
    t.index ["category_id"], name: "index_item_assignments_on_category_id"
    t.index ["employee_id"], name: "index_item_assignments_on_employee_id"
    t.index ["item_id"], name: "index_item_assignments_on_item_id"
  end

  create_table "item_requests", force: :cascade do |t|
    t.string "item"
    t.integer "quantity"
    t.text "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "employee_id"
    t.integer "status", default: 2
    t.date "approved_date"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "vendor_id"
    t.integer "quantity"
    t.date "purchased_date"
    t.integer "assigned_quantity"
    t.bigint "category_id"
    t.integer "withdrawn_quantity"
    t.integer "available_quantity"
    t.integer "remaining_quantity"
    t.integer "status", default: 0
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["vendor_id"], name: "index_items_on_vendor_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "quantity"
    t.integer "rate"
    t.date "purchased_date"
    t.bigint "item_id", null: false
    t.bigint "vendor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_purchases_on_category_id"
    t.index ["item_id"], name: "index_purchases_on_item_id"
    t.index ["vendor_id"], name: "index_purchases_on_vendor_id"
  end

  create_table "user_comments", force: :cascade do |t|
    t.text "body"
    t.bigint "item_request_id", null: false
    t.bigint "admin_user_id"
    t.bigint "employee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_user_comments_on_admin_user_id"
    t.index ["employee_id"], name: "index_user_comments_on_employee_id"
    t.index ["item_request_id"], name: "index_user_comments_on_item_request_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.integer "pan_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "withdraws", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_withdraws_on_category_id"
    t.index ["item_id"], name: "index_withdraws_on_item_id"
  end

  add_foreign_key "commontator_comments", "commontator_comments", column: "parent_id", on_update: :restrict, on_delete: :cascade
  add_foreign_key "commontator_comments", "commontator_threads", column: "thread_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "commontator_subscriptions", "commontator_threads", column: "thread_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "item_assignments", "categories"
  add_foreign_key "item_assignments", "employees"
  add_foreign_key "item_assignments", "items"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "vendors"
  add_foreign_key "purchases", "categories"
  add_foreign_key "purchases", "items"
  add_foreign_key "purchases", "vendors"
  add_foreign_key "user_comments", "admin_users"
  add_foreign_key "user_comments", "employees"
  add_foreign_key "user_comments", "item_requests"
  add_foreign_key "withdraws", "categories"
  add_foreign_key "withdraws", "items"
end
