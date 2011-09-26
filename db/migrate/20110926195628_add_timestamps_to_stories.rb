class AddTimestampsToStories < ActiveRecord::Migration
  def self.up
    change_table :stories do |t|
      t.timestamps
    end
  end

  def self.down
    remove_column :stories, :created_at
    remove_column :stories, :updated_at
  end
end
