require 'net/http'
require 'json'

class StaticController < ApplicationController

  def index
  end

  def nearme
    if current_user.id == nil
      @google = "Please log in to use this feature"
    else

      @user = User.find(current_user.id)
      @user_postcode = @user.postcode

      postcode_url = "https://api.postcodes.io/postcodes/#{@user_postcode.split(" ").join}"
      uri_postcode = URI(postcode_url)
      postcode_response = Net::HTTP.get(uri_postcode)
      @postcode = JSON.parse(postcode_response)

      url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{geounits}&radius=500&type=restaurant&keyword=chinese&key=AIzaSyAWHIVYglIX-UITv9CS6aXjTkrfL7Zm200"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      @google = JSON.parse(response)
    end
  end
end

private

def geounits
  "#{@postcode["result"]["latitude"]},#{@postcode["result"]["longitude"]}"
end
