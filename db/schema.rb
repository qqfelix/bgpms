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

ActiveRecord::Schema.define(version: 20160217074529) do

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "dicts", force: :cascade do |t|
    t.string   "dict_key",   limit: 255
    t.string   "dict_value", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "project_id",       limit: 4
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "doc_file_name",    limit: 255
    t.string   "doc_content_type", limit: 255
    t.integer  "doc_file_size",    limit: 4
    t.datetime "doc_updated_at"
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.boolean  "mon_am",      limit: 1
    t.string   "mon_amdesc",  limit: 255
    t.boolean  "mon_pm",      limit: 1
    t.string   "mon_pmdesc",  limit: 255
    t.boolean  "tues_am",     limit: 1
    t.string   "tues_amdesc", limit: 255
    t.boolean  "tues_pm",     limit: 1
    t.string   "tues_pmdesc", limit: 255
    t.boolean  "wed_am",      limit: 1
    t.string   "wed_amdesc",  limit: 255
    t.boolean  "wed_pm",      limit: 1
    t.string   "wed_pmdesc",  limit: 255
    t.boolean  "thur_am",     limit: 1
    t.string   "thur_amdesc", limit: 255
    t.boolean  "thur_pm",     limit: 1
    t.string   "thur_pmdesc", limit: 255
    t.boolean  "fri_am",      limit: 1
    t.string   "fri_amdesc",  limit: 255
    t.boolean  "fri_pm",      limit: 1
    t.string   "fri_pmdesc",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "month_reports", force: :cascade do |t|
    t.text     "mr_content", limit: 65535
    t.text     "mr_plan",    limit: 65535
    t.integer  "project_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "month_reports", ["project_id", "user_id"], name: "index_month_reports_on_project_id_and_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "p_no",          limit: 255
    t.string   "p_level",       limit: 255
    t.string   "p_name",        limit: 255
    t.integer  "p_author",      limit: 4
    t.string   "p_owner",       limit: 255
    t.string   "p_dept",        limit: 255
    t.date     "p_begin_date"
    t.date     "p_end_date"
    t.string   "p_status",      limit: 255
    t.text     "p_description", limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "team_id",       limit: 4
  end

  add_index "projects", ["team_id"], name: "index_projects_on_team_id", using: :btree

  create_table "projects_users", force: :cascade do |t|
    t.integer "project_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  add_index "projects_users", ["project_id", "user_id"], name: "index_projects_users_on_project_id_and_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "leader",     limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "phone",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "team_id",         limit: 4
    t.string   "auth_token",      limit: 255
  end

  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree

  create_table "week_reports", force: :cascade do |t|
    t.text     "wr_content",      limit: 65535
    t.text     "wr_plan",         limit: 65535
    t.integer  "project_id",      limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "month_report_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "week_reports", ["project_id", "user_id", "month_report_id"], name: "index_week_reports_on_project_id_and_user_id_and_month_report_id", using: :btree

  create_table "work_one_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "work_sheets", force: :cascade do |t|
    t.datetime "work_datetime"
    t.string   "username",            limit: 255
    t.string   "work_type",           limit: 255
    t.string   "work_type1",          limit: 255
    t.string   "work_type2",          limit: 255
    t.string   "work_place",          limit: 255
    t.string   "work_person",         limit: 255
    t.string   "work_person_phone",   limit: 255
    t.text     "work_description",    limit: 4294967295
    t.string   "work_demand",         limit: 255
    t.datetime "work_benin_datetime"
    t.datetime "work_end_datetime"
    t.integer  "user_id",             limit: 4
    t.string   "work_content",        limit: 255
    t.string   "work_status",         limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "project_id",          limit: 4
    t.string   "classify_code",       limit: 255
    t.string   "acc_no",              limit: 255
    t.string   "work_leader",         limit: 255
    t.string   "work_mode",           limit: 255
    t.string   "work_rate",           limit: 255
    t.string   "work_status2",        limit: 255
    t.string   "program_nums",        limit: 255
  end

  create_table "work_two_types", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "work_one_type_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

end
