class ChangeUsersTable < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.remove :admin_flag
      t.remove :instructor_flag
      t.remove :student_flag
      t.column :role, :string
    end
  end
end
