class AddHoursWorkedToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :hours_worked, :decimal
  end

  def self.down
    remove_column :stories, :hours_worked
  end
end
