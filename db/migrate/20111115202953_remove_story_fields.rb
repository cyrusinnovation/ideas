class RemoveStoryFields < ActiveRecord::Migration
  def change
    remove_column :stories, :finished
    remove_column :stories, :estimate
    remove_column :stories, :hours_worked
  end
end
