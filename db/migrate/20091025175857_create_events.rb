class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.timestamp :time, :null => false
      t.boolean   :type, :null => false
    end
  end

  def self.down
    drop_table :events
  end
end
