class CreateJoinTableCourseQualification < ActiveRecord::Migration[7.0]
  def change
    create_join_table :applications, :courses, table_name: :course_qualifications
      # t.index [:application_id, :course_id]
      # t.index [:course_id, :application_id]
    
  end
end
