class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.integer :target_point_size, :default => 8
      t.string :name
    end

    create_table :memberships do |t|
      t.references :user
      t.references :project
    end

    add_column :buckets, :project_id, :integer
    add_column :stories, :project_id, :integer

    User.all.each do |user|
      project = Project.create :name => "#{user.email.sub /@.*/, ''}'s project", :target_point_size => user.target_point_size
      user.projects << project
      user.save
      
      Bucket.find_all_by_user_id(user.id).each { |b| b.project = project; b.save }
      Story.find_all_by_user_id(user.id).each { |s| s.project = project; s.save }
    end

    remove_column :buckets, :user_id
    remove_column :stories, :user_id
    remove_column :users, :target_point_size
  end

  def down
    drop_table :projects
    drop_table :memberships
    remove_column :users, :project_id
    remove_column :buckets, :project_id
    remove_column :stories, :project_id

    add_column :buckets, :user_id, :integer
    add_column :stories, :user_id, :integer
    add_column :users, :target_point_size, :integer
  end
end
