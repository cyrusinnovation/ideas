class DropTableHolidays < ActiveRecord::Migration
  def change
    drop_table :holidays
  end
end
