class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_section
  has_many :sections, through: :user_section

  validates :email, format: /[A-Za-z]+\.[0-9]+@osu\.edu/
end
