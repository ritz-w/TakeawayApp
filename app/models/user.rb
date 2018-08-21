class User < ApplicationRecord
  has_and_belongs_to_many :restaurants
  has_and_belongs_to_many :dishes
end
