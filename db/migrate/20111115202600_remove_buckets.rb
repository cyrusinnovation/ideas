class RemoveBuckets < ActiveRecord::Migration
  def change
    drop_table :buckets    
  end
end
