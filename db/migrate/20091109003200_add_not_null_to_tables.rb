class AddNotNullToTables < ActiveRecord::Migration
  def self.up
    change_column :admins, :username,      :string,  :null => false
    change_column :admins, :password_hash, :string,  :null => false
    change_column :events, :person_id,     :int,     :null => false
    change_column :people, :first_name,    :string,  :null => false
    change_column :people, :last_name,     :string,  :null => false
    change_column :people, :visible,       :boolean, :null => false
  end

  def self.down
    change_column :admins, :username,      :string,  :null => true
    change_column :admins, :password_hash, :string,  :null => true
    change_column :events, :person_id,     :int,     :null => true
    change_column :people, :first_name,    :string,  :null => true
    change_column :people, :last_name,     :string,  :null => true
    change_column :people, :visible,       :boolean, :null => true
  end
end
