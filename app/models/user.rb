class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: true}
  validates :email, presence: true, uniqueness: true
    # enum role %i[normal admin]
end
