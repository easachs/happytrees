# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_220_906_174_744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'parks', force: :cascade do |t|
    t.string 'name'
    t.boolean 'affluent'
    t.integer 'year'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'trees', force: :cascade do |t|
    t.string 'species'
    t.boolean 'healthy'
    t.integer 'diameter'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'park_id'
    t.index ['park_id'], name: 'index_trees_on_park_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'trees', 'parks'
end
