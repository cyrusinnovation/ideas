class CreateBuckets < ActiveRecord::Migration
  def self.up
    create_table :buckets do |t|
      t.float :value

      t.timestamps
      t.references :user
    end

    User.all.each do |user|
      user.buckets << [0.25,0.5, 1, 2, 3, 5, 8, 13].map { |bucket| Bucket.create :value => bucket }
    end
  end

  def self.down
    drop_table :buckets
  end
end



