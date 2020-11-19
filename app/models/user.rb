class User < ApplicationRecord
  has_secure_password

  validates :username, { :uniqueness => true, :presence => true }
end
