class Restaurant < ApplicationRecord
  has_and_belongs_to_many :dishes
  has_and_belongs_to_many :users


  geocoded_by :get_address
  before_create :check_number
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode

    def get_address
      if self.address != nil
      "#{self.address + " " + self.postcode}"
      else
      self.postcode
      end
    end

    def check_number
      self.number.to_f
    end
end
