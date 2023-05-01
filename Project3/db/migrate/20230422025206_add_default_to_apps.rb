# frozen_string_literal: true

class AddDefaultToApps < ActiveRecord::Migration[7.0]
  def change
    change_column_default :applications, :is_accepted, from: nil, to: false
  end
end
