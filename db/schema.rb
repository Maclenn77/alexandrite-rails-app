# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_125_004_341) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'books', force: :cascade do |t|
    t.bigint 'book_id', null: false
    t.string 'title', null: false
    t.string 'authors', default: [], array: true
    t.string 'publisher'
    t.text 'description'
    t.string 'language'
    t.string 'country'
    t.bigint 'isbn10'
    t.bigint 'isbn13'
    t.string 'ddc'
    t.string 'lcc'
    t.string 'categories', default: [], array: true
    t.integer 'page_count'
    t.date 'published_date'
    t.string 'suggested_classifications', default: [], array: true
    t.string 'error_message'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'data_source'
  end

  create_table 'error_messages', force: :cascade do |t|
    t.text 'message'
    t.string 'origin'
    t.text 'details'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'error_id'
  end
end
