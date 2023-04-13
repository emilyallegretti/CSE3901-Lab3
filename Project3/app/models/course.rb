class Course < ApplicationRecord
  
  has_many :sections, :dependent => :destroy
  has_many :course_preference, :dependent => :destroy
  has_many :applications, through: :course_preference, :dependent => :destroy
  has_many :course_qualification, :dependent => :destroy
  has_many :applications, through: :course_qualification, :dependent => :destroy
end
