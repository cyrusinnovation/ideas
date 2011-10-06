class CreateBuckets < ActiveRecord::Migration
  def self.up
    create_table :buckets do |t|
      t.float :value

      t.timestamps
      t.references :user
    end
  end

  def self.down
    drop_table :buckets
  end
end



