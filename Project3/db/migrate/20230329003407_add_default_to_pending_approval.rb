# frozen_string_literal: true

class AddDefaultToPendingApproval < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :pending_approval, from: nil, to: true
  end
end
