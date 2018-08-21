class User < ApplicationRecord
  has_and_belongs_to_many :restaurants
  has_and_belongs_to_many :dishes
  validates :username, uniqueness: true, presence: true
  has_secure_password
end
