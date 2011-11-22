class CreateFavoriteIdeas < ActiveRecord::Migration
  def change
    create_table :favorite_ideas do |t|
      t.references :user
      t.references :idea
      t.timestamps
    end
  end
end
