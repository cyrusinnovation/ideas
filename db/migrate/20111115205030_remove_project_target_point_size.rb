class RemoveProjectTargetPointSize < ActiveRecord::Migration
  def change
    remove_column :projects, :target_point_size
  end
end
