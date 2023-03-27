class ChangeNullConstrain < ActiveRecord::Migration[7.0]
  def change
    change_column :sections, :start_time , :null => true
    change_column :sections, :end_time , :null => true
  end
  
end
