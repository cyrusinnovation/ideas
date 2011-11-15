class RenameStoryToIdea < ActiveRecord::Migration
  def change
    rename_table :stories, :ideas
  end
end
