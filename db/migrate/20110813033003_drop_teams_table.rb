class DropTeamsTable < ActiveRecord::Migration
  def self.up
    drop_table "teams"
  end

  def self.down
    create_table "teams", :force => true do |t|
      t.string "name"
    end
  end
end
