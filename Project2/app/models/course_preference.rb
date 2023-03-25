class CoursePreference < ApplicationRecord
    self.table_name = "course_preferences"
    belongs_to :application
    belongs_to :course
end