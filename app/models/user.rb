class User < ApplicationRecord

  enum role: [:admin, :guest]

  validates :username, presence: true, uniqueness: true
  validates :role, presence: true

end
