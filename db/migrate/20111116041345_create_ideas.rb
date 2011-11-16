class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.integer  "project_id"
      t.string   "description"
      t.references "project_id"
      t.timestamps
    end
  end
end
