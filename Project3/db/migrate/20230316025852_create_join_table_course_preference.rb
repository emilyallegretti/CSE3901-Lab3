# frozen_string_literal: true

class CreateJoinTableCoursePreference < ActiveRecord::Migration[7.0]
  def change
    create_join_table :applications, :courses, table_name: :course_preferences
  end
end
