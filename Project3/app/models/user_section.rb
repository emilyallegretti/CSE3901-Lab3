class UserSection < ApplicationRecord
    self.table_name = "sections_users"
    belongs_to :section
    belongs_to :user
end
