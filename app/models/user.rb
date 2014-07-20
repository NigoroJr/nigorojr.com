class User < ActiveRecord::Base
  attr_accessor :raw_password, :raw_password_confirmation

  validates :raw_password, confirmation: true
  validates :raw_password_confirmation, presence: true
  validates :username, uniqueness: true

  def raw_password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
  end

  class << self
    def authenticate(username, password)
      user = User.find_by_username(username)

      if user && user.hashed_password.present? &&
        BCrypt::Password.new(user.hashed_password) == password
        return user
      else
        return nil
      end
    end
  end
end
