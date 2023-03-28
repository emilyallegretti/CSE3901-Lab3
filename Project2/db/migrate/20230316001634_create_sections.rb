class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.integer :num_graders_required, default: 1, null: false
      t.integer :section_number, null:false
      t.string :start_time
      t.string :end_time
      t.string :location
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.boolean :sunday      
      t.string :mode_of_instruction
      t.timestamps
    end
  end
end
