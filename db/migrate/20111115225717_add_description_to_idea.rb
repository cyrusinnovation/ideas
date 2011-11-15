class AddDescriptionToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :description, :string
  end
end
