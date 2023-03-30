class Course < ApplicationRecord
  self.primary_key = 'number'
  has_many :sections, primary_key: 'number',foreign_key: 'course_num', :dependent => :destroy
  has_many :course_preference
  has_many :applications, through: :course_preference
  has_many :course_qualification
  has_many :applications, through: :course_qualification
end
