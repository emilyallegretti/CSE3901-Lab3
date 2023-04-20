# frozen_string_literal: true

class AddUserSignupDefaults < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :role, from: nil, to: 'student'
  end
end
