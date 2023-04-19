class CourseQualification < ApplicationRecord
    self.table_name = "course_qualifications"
    self.primary_key = "application_id"
    belongs_to :application
    belongs_to :course
end