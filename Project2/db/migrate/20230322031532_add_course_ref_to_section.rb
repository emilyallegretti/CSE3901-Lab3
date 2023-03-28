class AddCourseRefToSection < ActiveRecord::Migration[7.0]
  def change
    add_reference :sections,:course_num, references: :course, index: true
    rename_column :sections, :course_num_id, :course_num
    add_foreign_key :sections, :courses, column: 'course_num', primary_key: 'number'
  end
end
