class AddCreatedByToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :created_by, :string
  end
end
