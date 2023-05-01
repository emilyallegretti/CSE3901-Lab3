# frozen_string_literal: true

class AddUserRefToRecommendations < ActiveRecord::Migration[7.0]
  def change
    add_reference :recommendations, :user
  end
end
