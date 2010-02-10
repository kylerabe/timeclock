require 'bcrypt'

class Admin < ActiveRecord::Base
  include BCrypt

  attr_accessor :new_password

  validates_presence_of     :username
  validates_uniqueness_of   :username
  validates_confirmation_of :new_password
  validates_presence_of     :new_password, :if => :password_new?

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def password_new?
    self.new_record?
  end

end
