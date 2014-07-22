class User < ActiveRecord::Base
  attr_accessor :raw_password, :raw_password_confirmation

  validates_uniqueness_of :username

  def raw_password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
  end

  # Returns whether this user has access to (i.e. can edit/delete) given post
  # POST is a model object
  def can_modify(model)
    if model == nil
      return false
    end

    # "User" model object does not have a "posted_by" field
    owner = model.instance_of?(User) ? model.username : model.posted_by

    return owner == self.username ||
      self.username == UsersController::ROOT
  end

  class << self
    def authenticate(username, password)
      user = User.find_by_username(username.downcase)

      if user && user.hashed_password.present? &&
        BCrypt::Password.new(user.hashed_password) == password
        return user
      else
        return nil
      end
    end

    # Returns the screen name for the given username.
    # Returns username if no screen name is registered.
    def username_to_screen(username)
      user = User.find_by_username(username.downcase)

      if user == nil || user.screen.empty?
        return username
      else
        return user.screen
      end
    end
  end
end
