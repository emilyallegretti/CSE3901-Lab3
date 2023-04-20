# frozen_string_literal: true

class ChangePendingApprovalFlag < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.remove :pending_approval?
      t.column :pending_approval, :boolean
    end
  end
end
