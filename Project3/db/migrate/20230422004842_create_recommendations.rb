class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.string :instructor_email
      t.string :student_email
      t.string :message, default: nil
      t.string :course_name, default: nil
      t.string :section_num, default: nil
      t.timestamps
    end
  end
end
