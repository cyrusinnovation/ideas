class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
    end
    remove_column :stories, :team
    change_table :stories do |t|
      t.belongs_to :team
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't put the team names back in the box."
  end
end
