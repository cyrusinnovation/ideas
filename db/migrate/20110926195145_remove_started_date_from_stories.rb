class RemoveStartedDateFromStories < ActiveRecord::Migration
  def self.up
    remove_column :stories, :started
  end

  def self.down
    add_column :stories, :started, :date
  end
end
