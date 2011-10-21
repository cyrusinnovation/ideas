class RemoveTeamIdFromStory < ActiveRecord::Migration
  def change
    remove_column :stories, :team_id
  end
end
