# This model represents the Applications table in the database.
class Application < ApplicationRecord
    has_many :availabilities, :dependent => :destroy
    has_many :course_preference, :dependent => :destroy
    has_many :courses, through: :course_preference, :dependent => :destroy

    has_many :course_qualification, :dependent => :destroy
    has_many :courses, through: :course_qualification, :dependent => :destroy
end
