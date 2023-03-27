class ChangeSectionDaysToBoolean < ActiveRecord::Migration[7.0]
  def change
    change_table :sections do |t|
  t.change :monday, :boolean
  t.change :tuesday, :boolean
  t.change :wednesday, :boolean
  t.change :thursday,:boolean
  t.change :friday, :boolean
  t.change :saturday, :boolean
  t.change :sunday, :boolean
end
  end
end
