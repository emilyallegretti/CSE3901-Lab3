# This model represents the Applications table in the database.
class Application < ApplicationRecord
    has_many :availabilities
end
