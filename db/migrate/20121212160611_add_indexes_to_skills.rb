class AddIndexsToSkills < ActiveRecord::Migration[4.2]
  def change
    add_index :skill, :user_id
  end
end
