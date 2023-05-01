# frozen_string_literal: true

class CoursePreference < ApplicationRecord
  self.table_name = 'course_preferences'
  self.primary_key = 'application_id'
  belongs_to :application
  belongs_to :course
end
