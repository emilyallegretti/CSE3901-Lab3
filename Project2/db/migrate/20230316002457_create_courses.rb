class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t| #, id: false, primary_key: :number
      t.integer :number
      t.string :name
      t.string :campus
      t.string :term

      t.timestamps
    end
  end
end
