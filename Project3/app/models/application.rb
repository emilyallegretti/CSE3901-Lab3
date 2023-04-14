# This model represents the Applications table in the database.
class Application < ApplicationRecord
    has_many :availabilities, :dependent => :destroy
    belongs_to :user
    has_many :course_preference, :dependent => :destroy
    has_many :courses, through: :course_preference, :dependent => :destroy

    has_many :course_qualification, :dependent => :destroy
    has_many :courses, through: :course_qualification, :dependent => :destroy

    validates :term, uniqueness: {message: "You may only submit 1 grader application per term"}
end
