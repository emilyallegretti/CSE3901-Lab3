class CourseQualification < ApplicationRecord
    self.table_name = "course_qualifications"
    belongs_to :application
    belongs_to :course
end