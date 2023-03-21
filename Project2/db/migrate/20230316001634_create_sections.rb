class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.integer :num_graders_required, default: 1, null: false
      t.integer :section_number, null:false
      t.string :start_time, null: false
      t.string :end_time, null: false
      t.string :location
      t.string :days_of_week, null: false
      t.string :mode_of_instruction
      t.timestamps
    end
  end
end
