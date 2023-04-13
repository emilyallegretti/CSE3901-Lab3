class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :term
      t.string :campus
      t.timestamps
    end
  end
end
