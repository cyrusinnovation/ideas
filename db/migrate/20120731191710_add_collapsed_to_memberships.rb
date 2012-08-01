class AddCollapsedToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :collapsed, :boolean,  :null => false, :default => false
  end
end
