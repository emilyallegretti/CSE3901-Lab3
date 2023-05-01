# frozen_string_literal: true

class AddApplicationRefToAvailability < ActiveRecord::Migration[7.0]
  def change
    add_reference :availabilities, :application, null: false, foreign_key: true
  end
end
