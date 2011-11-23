class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user
      t.references :idea
      t.integer :rating
      t.timestamps
    end
  end
end
