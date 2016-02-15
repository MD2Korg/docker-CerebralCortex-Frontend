# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160214210937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "datapoints", force: :cascade do |t|
    t.datetime "timestamp"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "datastream_id"
    t.jsonb    "sample"
  end

  add_index "datapoints", ["datastream_id"], name: "index_datapoints_on_datastream_id", using: :btree

  create_table "datasources", force: :cascade do |t|
    t.string   "identifier"
    t.string   "datasourcetype"
    t.jsonb    "datadescriptor"
    t.jsonb    "metadata"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "m_cerebrum_application_id"
    t.integer  "m_cerebrum_platform_id"
    t.integer  "m_cerebrum_platform_app_id"
  end

  add_index "datasources", ["m_cerebrum_application_id"], name: "index_datasources_on_m_cerebrum_application_id", using: :btree
  add_index "datasources", ["m_cerebrum_platform_app_id"], name: "index_datasources_on_m_cerebrum_platform_app_id", using: :btree
  add_index "datasources", ["m_cerebrum_platform_id"], name: "index_datasources_on_m_cerebrum_platform_id", using: :btree

  create_table "datastreams", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "datasource_id"
    t.integer  "participant_id"
  end

  add_index "datastreams", ["datasource_id"], name: "index_datastreams_on_datasource_id", using: :btree
  add_index "datastreams", ["participant_id"], name: "index_datastreams_on_participant_id", using: :btree

  create_table "m_cerebrum_applications", force: :cascade do |t|
    t.string "applicationtype"
    t.string   "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb    "metadata"
  end

  create_table "m_cerebrum_platform_apps", force: :cascade do |t|
    t.string   "platformapptype"
    t.string   "identifier"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.jsonb    "metadata"
  end

  create_table "m_cerebrum_platforms", force: :cascade do |t|
    t.string   "platformtype"
    t.string   "identifier"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.jsonb    "metadata"
  end

  create_table "participant_studies", force: :cascade do |t|
    t.integer "participant_id"
    t.integer "study_id"
  end

  add_index "participant_studies", ["participant_id"], name: "index_participant_studies_on_participant_id", using: :btree
  add_index "participant_studies", ["study_id"], name: "index_participant_studies_on_study_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.string   "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "studies", force: :cascade do |t|
    t.string   "identifier"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "datapoints", "datastreams"
  add_foreign_key "datasources", "m_cerebrum_applications"
  add_foreign_key "datasources", "m_cerebrum_platform_apps"
  add_foreign_key "datasources", "m_cerebrum_platforms"
  add_foreign_key "datastreams", "datasources"
  add_foreign_key "datastreams", "participants"
  add_foreign_key "participant_studies", "participants"
  add_foreign_key "participant_studies", "studies"
end
