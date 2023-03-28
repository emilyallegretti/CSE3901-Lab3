class Course < ApplicationRecord
    self.primary_key = 'number'
    has_many :sections, primary_key: 'number',foreign_key: 'course_num'
end
