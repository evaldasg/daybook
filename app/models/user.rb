class User < ActiveRecord::Base
  has_secure_password
  validates :name, :username, :email, presence: true
  validates :email, :username, uniqueness: { case_sensitive: false }
  validates :email, format: /\A\S+@\S+\z/
  validates :password, length: { minimum: 6, allow_balnk: true }

end
