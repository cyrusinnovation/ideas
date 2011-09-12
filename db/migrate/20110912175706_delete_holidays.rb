class DeleteHolidays < ActiveRecord::Migration

  def self.up
    drop_table :holidays
  end

  def self.down
    create_table :holidays do |t|
      t.date :date
      t.string :description

      t.timestamps
    end
  end
end
