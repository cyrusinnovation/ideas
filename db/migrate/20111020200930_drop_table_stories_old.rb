class DropTableStoriesOld < ActiveRecord::Migration
  def change
    drop_table :stories_old
  end
end
