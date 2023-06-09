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

ActiveRecord::Schema[7.0].define(version: 20_230_422_025_206) do
  create_table 'applications', force: :cascade do |t|
    t.string 'campus'
    t.string 'term'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id', null: false
    t.boolean 'is_accepted', default: false
    t.index ['user_id'], name: 'index_applications_on_user_id'
  end

  create_table 'availabilities', force: :cascade do |t|
    t.string 'start_time'
    t.string 'end_time'
    t.string 'day_of_week'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'application_id', null: false
    t.index ['application_id'], name: 'index_availabilities_on_application_id'
  end

  create_table 'course_preferences', id: false, force: :cascade do |t|
    t.integer 'application_id', null: false
    t.integer 'course_id', null: false
  end

  create_table 'course_qualifications', id: false, force: :cascade do |t|
    t.integer 'application_id', null: false
    t.integer 'course_id', null: false
  end

  create_table 'courses', force: :cascade do |t|
    t.integer 'number'
    t.string 'name'
    t.string 'campus'
    t.string 'term'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'recommendations', force: :cascade do |t|
    t.string 'instructor_email'
    t.string 'student_email'
    t.string 'message'
    t.string 'course_name'
    t.string 'section_num'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.index ['user_id'], name: 'index_recommendations_on_user_id'
  end

  create_table 'sections', force: :cascade do |t|
    t.integer 'num_graders_required', default: 1, null: false
    t.string 'section_number', null: false
    t.string 'start_time'
    t.string 'end_time'
    t.string 'location'
    t.boolean 'monday'
    t.boolean 'tuesday'
    t.boolean 'wednesday'
    t.boolean 'thursday'
    t.boolean 'friday'
    t.boolean 'saturday'
    t.boolean 'sunday'
    t.string 'mode_of_instruction'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'course_id'
    t.index ['course_id'], name: 'index_sections_on_course_id'
  end

  create_table 'sections_users', id: false, force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'section_id', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'fname', null: false
    t.string 'lname'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'role', default: 'student'
    t.boolean 'pending_approval', default: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'applications', 'users'
  add_foreign_key 'availabilities', 'applications'
end
