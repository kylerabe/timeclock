class AddPersonIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :person_id, :integer
  end

  def self.down
    remove_column :events, :person_id
  end
end
