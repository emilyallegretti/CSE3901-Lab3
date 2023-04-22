# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_section, dependent: :destroy
  has_many :sections, through: :user_section, dependent: :destroy
  has_many :recommendations, dependent: :destroy

  # Checks that when a user signs up, the email format follows name.#@osu.edu.
  validates :email, format: /[A-Za-z]+\.[0-9]+@osu\.edu/
end
