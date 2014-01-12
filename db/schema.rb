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

ActiveRecord::Schema.define(version: 20140111155305) do

  create_table "events", force: true do |t|
    t.string   "event_name"
    t.date     "event_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participantCount"
  end

  create_table "events_movies", id: false, force: true do |t|
    t.integer "event_id", null: false
    t.integer "movie_id", null: false
  end

  add_index "events_movies", ["event_id", "movie_id"], name: "index_events_movies_on_event_id_and_movie_id", unique: true

  create_table "movies", force: true do |t|
    t.string   "movie_name"
    t.string   "movie_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
