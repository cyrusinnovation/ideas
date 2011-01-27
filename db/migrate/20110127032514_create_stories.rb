class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :title
      t.string :team
      t.decimal :estimate, :precision => 3, :scale => 1
      t.date :started
      t.date :finished
    end
  end

  def self.down
    drop_table :stories
  end
end
