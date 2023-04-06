class Section < ApplicationRecord
    belongs_to :course
    has_many :user_section
    has_many :users, through: :user_section
end
