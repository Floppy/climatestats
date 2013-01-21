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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130121075709) do

  create_table "datasets", :force => true do |t|
    t.string   "shortname"
    t.string   "fullname"
    t.string   "data_uri"
    t.string   "info_uri"
    t.integer  "year_column"
    t.integer  "month_column"
    t.integer  "data_column"
    t.integer  "compare_to"
    t.string   "units"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "measurements", :force => true do |t|
    t.float    "value"
    t.date     "measured_on"
    t.integer  "dataset_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "measurements", ["dataset_id"], :name => "index_measurements_on_dataset_id"

end
