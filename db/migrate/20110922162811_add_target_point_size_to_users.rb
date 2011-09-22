class AddTargetPointSizeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :target_point_size, :integer, :default => 8
    
    execute 'update users set target_point_size = 8'
  end

  def self.down
    remove_column :users, :target_point_size
  end
end
