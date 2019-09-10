# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_909_084_134) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author_type_and_author_id'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource_type_and_resource_id'
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.string 'type'
    t.float 'depreciation_rate'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'employees', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'first_name'
    t.string 'last_name'
    t.string 'invitation_token'
    t.datetime 'invitation_created_at'
    t.datetime 'invitation_sent_at'
    t.datetime 'invitation_accepted_at'
    t.integer 'invitation_limit'
    t.string 'invited_by_type'
    t.bigint 'invited_by_id'
    t.integer 'invitations_count', default: 0
    t.index ['email'], name: 'index_employees_on_email', unique: true
    t.index ['invitation_token'], name: 'index_employees_on_invitation_token', unique: true
    t.index ['invitations_count'], name: 'index_employees_on_invitations_count'
    t.index ['invited_by_id'], name: 'index_employees_on_invited_by_id'
    t.index %w[invited_by_type invited_by_id], name: 'index_employees_on_invited_by_type_and_invited_by_id'
    t.index ['reset_password_token'], name: 'index_employees_on_reset_password_token', unique: true
  end

  create_table 'item_assignments', force: :cascade do |t|
    t.integer 'quantity'
    t.bigint 'employee_id', null: false
    t.bigint 'item_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['employee_id'], name: 'index_item_assignments_on_employee_id'
    t.index ['item_id'], name: 'index_item_assignments_on_item_id'
  end

  create_table 'item_requests', force: :cascade do |t|
    t.string 'item'
    t.integer 'quantity'
    t.text 'reason'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'employee_id'
    t.integer 'status', default: 2
  end

  create_table 'items', force: :cascade do |t|
    t.string 'name'
    t.string 'type'
    t.integer 'rate'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'vendor_id'
    t.integer 'quantity'
    t.bigint 'category_id'
    t.date 'purchased_date'
    t.integer 'assigned_quantity'
    t.index ['category_id'], name: 'index_items_on_category_id'
    t.index ['vendor_id'], name: 'index_items_on_vendor_id'
  end

  create_table 'purchases', force: :cascade do |t|
    t.integer 'quantity'
    t.integer 'rate'
    t.date 'purchased_date'
    t.bigint 'item_id', null: false
    t.bigint 'vendor_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'category_id'
    t.index ['category_id'], name: 'index_purchases_on_category_id'
    t.index ['item_id'], name: 'index_purchases_on_item_id'
    t.index ['vendor_id'], name: 'index_purchases_on_vendor_id'
  end

  create_table 'vendors', force: :cascade do |t|
    t.string 'name'
    t.integer 'pan_no'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'item_assignments', 'employees'
  add_foreign_key 'item_assignments', 'items'
  add_foreign_key 'items', 'categories'
  add_foreign_key 'items', 'vendors'
  add_foreign_key 'purchases', 'categories'
  add_foreign_key 'purchases', 'items'
  add_foreign_key 'purchases', 'vendors'
end
