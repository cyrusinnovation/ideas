class AddUserIdToStories < ActiveRecord::Migration
  def self.up
    execute "delete from stories"
    add_column :stories, :user_id, :integer
  end

  def self.down
    remove_column :stories, :user_id
  end
end
