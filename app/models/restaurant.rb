class Restaurant < ApplicationRecord
  has_and_belongs_to_many :dishes
  has_and_belongs_to_many :users
end
