class Course < ApplicationRecord
  
  has_many :sections, :dependent => :destroy
  has_many :course_preference
  has_many :applications, through: :course_preference
  has_many :course_qualification
  has_many :applications, through: :course_qualification
end
