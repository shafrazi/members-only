class User < ApplicationRecord
  attr_accessor :remember_token

  validates :email, presence: true
  validates :name, presence: true
  has_secure_password

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = User.new_token
    self.update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    self.update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    remember_digest = self.remember_digest
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
