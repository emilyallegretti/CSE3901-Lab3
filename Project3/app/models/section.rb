# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :course
  has_many :user_section, dependent: :destroy
  has_many :users, through: :user_section, dependent: :destroy
end
