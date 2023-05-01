# frozen_string_literal: true

class AddColumnToApps < ActiveRecord::Migration[7.0]
  def change
    change_table :applications do |t|
      t.column :is_accepted, :boolean
    end
  end
end
