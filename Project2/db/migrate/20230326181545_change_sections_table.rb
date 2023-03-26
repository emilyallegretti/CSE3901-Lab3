class ChangeSectionsTable < ActiveRecord::Migration[7.0]
  def change
    change_table :sections do |t|
  t.remove :days_of_week
  t.column :monday, :string
  t.column :tuesday, :string
  t.column :wednesday, :string
  t.column :thursday, :string
  t.column :friday, :string
  t.column :saturday, :string
  t.column :sunday, :string
end
  end
end
