class CreateAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :availabilities do |t|
      t.string :start_time
      t.string :end_time
      t.string :day_of_week
      t.timestamps
    end
  end
end
