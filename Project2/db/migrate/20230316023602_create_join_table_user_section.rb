class CreateJoinTableUserSection < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :sections do |t|
      # t.index [:user_id, :section_id]
      # t.index [:section_id, :user_id]
    end
  end
end
