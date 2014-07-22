class User < ActiveRecord::Base
  attr_accessor :raw_password, :raw_password_confirmation

  validates_uniqueness_of :username

  def raw_password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
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
  end
end
