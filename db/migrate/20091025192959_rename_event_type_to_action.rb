class RenameEventTypeToAction < ActiveRecord::Migration
  def self.up
    rename_column :events, :type, :action
  end

  def self.down
    rename_column :events, :action, :type
  end
end
