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

ActiveRecord::Schema.define(version: 20130825105316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ruby_gems", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ruby_gems", ["name"], name: "index_ruby_gems_on_name", using: :btree

  create_table "versions", force: true do |t|
    t.integer  "ruby_gem_id"
    t.string   "number"
    t.integer  "major",         default: 0
    t.integer  "minor",         default: 0
    t.integer  "patch",         default: 0
    t.text     "release_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["major", "minor", "patch"], name: "index_versions_on_major_and_minor_and_patch", using: :btree
  add_index "versions", ["ruby_gem_id", "number"], name: "index_versions_on_ruby_gem_id_and_number", unique: true, using: :btree
  add_index "versions", ["ruby_gem_id"], name: "index_versions_on_ruby_gem_id", using: :btree

end
