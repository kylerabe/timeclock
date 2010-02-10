class Person < ActiveRecord::Base
  has_many :events, :dependent => :delete_all

  validates_presence_of   :first_name, :last_name
  validates_uniqueness_of :first_name, :scope => :last_name,
    :message => "and last name already taken"

  default_scope :order => 'first_name, last_name'
  named_scope :visible, :conditions => {:visible => true}

  def full_name
    self.first_name + " " + self.last_name
  end

  def status
    self.events.empty? ? 'N/A' : self.events.newest.action_name
  end

  def next_action
    self.events.empty? ? true : !self.events.newest.action
  end
end
