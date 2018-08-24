require 'wikipedia'
require 'byebug'

require 'net/http'
require 'json'

require 'geocoder'
require 'httparty'

# #
# # # url = 'https://developers.zomato.com/api/v2.1/search?entity_id=61&entity_type=city&cuisines=25&establishment_type=21'
# # # dish = "Chop suey"
# # # dish_url = 'https://en.wikipedia.org/w/api.php?action=query&titles=' + dish + '&generator=images&gimlimit=10&prop=imageinfo&iiprop=url|dimensions|mime&format=json'
# # # uri = URI(dish_url)
# # # response = Net::HTTP.get(uri)
# # p
# # # image_url = json["query"]["pages"]["-1"]["imageinfo"][0]["url"]
# # #
# # # keys = json["query"]["pages"].keys
# # # images = []
# # # keys.each do |key|
# # #   images << json["query"]["pages"]["#{key}"]["imageinfo"][0]["url"]
# # # end
# # # img_jpg_urls = images.select {|img| img.include?(".JPG") || img.include?(".jpg")}
# # #
# # # byebug
# # #
# # # wiki_page = Wikipedia.find('Hot and sour soup')
# # # byebug
# # # puts wiki_page.images
# # byebug
# # coord = User.all.first.postcode.coordinates
# #
# # <!-- <%= image_tag "https://loremflickr.com/320/240/#{@dish.name.split.join(",")}", class: "image" %> -->
# #
# #
# # <div class="container">
# #   <p>
# #   <div class="row title">
# #       <h1>Restaurants nearby</h1>
# #   </div>
# #   <% @nearest_resta.map do |restaurant| %>
# #   <div class="row closest-takeaways-row-separator">
# #     <div class="col-md-6">
# #       <h3><%= restaurant["name"]%></h3>
# #       <p><%= restaurant["vicinity"]%></p>
# #       <p><%= restaurant["geometry"]["location"]["lat"] %></p>
# #       <p><%= restaurant["geometry"]["location"]["lng"] %></p>
# #     </div>
# #     <div class="col-md-6">
# #       <div class="container closest-map-container" id="closest-map-<%= @google["results"].index(restaurant) %>">
# #       </div>
# #       <script>
# #       // Initialize and add the map
# #       function mapAddress(mapElement, address) {
# #
# #         var locations = <%= raw @google["results"].map do {|restaurant| [restaurant["name"], restaurant["geometry"]["location"]["lat"], restaurant["geometry"]["location"]["lng"], @google["results"].index(restaurant)]} %>;
# #         var geocoder = new google.maps.Geocoder();
# #         geocoder.geocode({ 'address': address }, function (results, status) {
# #             if (status == google.maps.GeocoderStatus.OK) {
# #                 var mapOptions = {
# #                     zoom: 14,
# #                     center: results[0].geometry.location,
# #                     disableDefaultUI: true
# #                 };
# #                 var map = new google.maps.Map(document.getElementById(mapElement), mapOptions);
# #                 var marker = new google.maps.Marker({
# #                     map: map,
# #                     position: results[0].geometry.location
# #                 });
# #             } else {
# #                 alert("Geocode was not successful for the following reason: " + status);
# #             }
# #         });
# #         }
# #
# #         console.log(locations)
# #
# #         </script>
# #         <script async defer
# #         src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAWHIVYglIX-UITv9CS6aXjTkrfL7Zm200&callback=initMap">
# #         </script>
# #     </div>
# #   </div>
# #   <% end %>
# # </div>
#
# def find_2km_restaurants
#   uri_postcode = URI("https://api.postcodes.io/postcodes/ec2a1nt")
#   postcode_response = Net::HTTP.get(uri_postcode)
#   @postcode = JSON.parse(postcode_response)
#   geounits = "#{@postcode["result"]["latitude"]},#{@postcode["result"]["longitude"]}"
#     url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{geounits}&radius=20000&type=restaurant&keyword=chinese&key=AIzaSyAWHIVYglIX-UITv9CS6aXjTkrfL7Zm200"
#     uri = URI(url)
#     response = Net::HTTP.get(uri)
#     @google = JSON.parse(response)
# end
#
# find_2km_restaurants
#
# result = Geocoder.search("8 Hanway Pl, London")
# byebug
#
#
# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# require 'wikipedia'
# require 'net/http'
# require 'json'
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
#
# def find_2km_restaurants
#   uri_postcode = URI("https://api.postcodes.io/postcodes/ec2a1nt")
#   postcode_response = Net::HTTP.get(uri_postcode)
#   @postcode = JSON.parse(postcode_response)
#   geounits = "#{@postcode["result"]["latitude"]},#{@postcode["result"]["longitude"]}"
#   url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{geounits}&radius=20000&type=restaurant&keyword=chinese&key=AIzaSyAWHIVYglIX-UITv9CS6aXjTkrfL7Zm200"
#   uri = URI(url)
#   response = Net::HTTP.get(uri)
#   JSON.parse(response)
# end
#
# google_results = find_2km_restaurants
#
# google_results["results"].each_with_index do |restaurant_hash, index|
#   Restaurant.create(name: restaurant_hash["name"], address: restaurant_hash["vicinity"], postcode: nil)
# end
#
#
#
# User.create([
#   {name: "Ritz Wu", username: "rizulol", password: "xoxo", postcode: "SE1 7LH", admin: true},
#   {name: "Adham Muhammad", username: "adham_eats", password: "xoxo", postcode: "SW16 1AA", admin: true},
#   {name: "Sarah Jacobs", username: "sarah_eats", password: "xoxo", postcode: "N15 5PX"},
#   {name: "Steven Balasta", username: "steven_eats", password: "xoxo", postcode: "EC2Y 1NT"},
#   {name: "Maduri Vassaramo", username: "maduri_eats", password: "xoxo", postcode: "SW7 2EU"}
#   ])
#
# Restaurant.create(name: "My Old Place", address: "88-90 Middlesex St, London", postcode: "E1 7EZ", phone_number: '020 72472200')
# Restaurant.create(name: "Taste of China", address: "53 Hackney Rd, London", postcode: " E2 7NX", phone_number: '020 77391228')
# Restaurant.create(name: "Ming Pat", address: "11 Cropley St, Islington, London", postcode: "N1 7PT", phone_number: '020 72501868')
# Restaurant.create(name: "Kung Food", address: "126A Middlesex St, Whitechapel, London", postcode: "E1 7HY", phone_number: '020 72471088')
# Restaurant.create(name: "Sam's Chinese Express", address: "61 Red Lion St, Holborn, London", postcode: "WC1R 4PD", phone_number: nil)
#
#
# dish_names = [
#   {"Sichuan" => ["Kung Pao chicken", "Hot and sour soup"]},
#   {"Guangdong" => ["Chow mein", "Chop suey", "Chicken feet", "Shrimp toast"]},
#   {"Beijing" => ["Peking duck", "Spring roll"]},
#   # {"Fujian" => ["Hokkien fried rice"]},
#   # {"Indonesia" => ["Prawn crackers"]},
#   # {"Taiwan" => ["Ta-a noodles", "Pork ball"]}
# ]
#
# dish_names.each do |dish_name|
#   region = dish_name.keys[0]
#   dishes_array = dish_name.values[0]
#   dishes_array.each do |dish|
#     wiki_page = Wikipedia.find(dish)
#     dish_url = 'https://en.wikipedia.org/w/api.php?action=query&titles=' + dish + '&generator=images&gimlimit=10&prop=imageinfo&iiprop=url|dimensions|mime&format=json'
#     uri = URI(dish_url)
#     response = Net::HTTP.get(uri)
#     json = JSON.parse(response)
#     keys = json["query"]["pages"].keys
#     images = []
#     keys.each do |key|
#       images << json["query"]["pages"]["#{key}"]["imageinfo"][0]["url"]
#     end
#     img_jpg_urls = images.select {|img| img.include?(".JPG") || img.include?(".jpg")}
#     img_jpg_urls << "https://loremflickr.com/320/240/#{dish.split.join(",")}"
#     Dish.create(name: dish, description: wiki_page.summary, region: region, photo_1: img_jpg_urls[1], photo_2: img_jpg_urls[2], photo_3: img_jpg_urls.last)
#   end
# end



#
# def find_2km_restaurants
#   uri_postcode = URI("https://api.postcodes.io/postcodes/ec2a1nt")
#   postcode_response = Net::HTTP.get(uri_postcode)
#   @postcode = JSON.parse(postcode_response)
#   geounits = "#{@postcode["result"]["latitude"]},#{@postcode["result"]["longitude"]}"
#   url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{geounits}&radius=20000&type=restaurant&keyword=chinese&key=AIzaSyAWHIVYglIX-UITv9CS6aXjTkrfL7Zm200"
#   uri = URI(url)
#   response = Net::HTTP.get(uri)
#   google_results = JSON.parse(response)
#   info_hash = []
#   google_results["results"].each_with_index do |restaurant_hash, index|
#     results = Geocoder.search(restaurant_hash["vicinity"])
#     if results.empty?
#       postcode = 0
#     else
#       postcode = results.first.postal_code
#     end
#     info_hash << [restaurant_hash["name"], restaurant_hash["vicinity"], postcode]
#   end
#   info_hash
# end
#




def find_images
  dish_names = [{"Sichuan" => ["Kung Pao chicken", "Hot and sour soup"]},
  {"Guangdong" => ["Chow mein", "Chop suey", "Shrimp toast"]},
  {"Taiwan" => ["Pork ball", "Yi mein"]},
  {"Beijing" => ["Peking duck", "Spring roll", "Stir-fried tomato and scrambled eggs", "Moo shu pork"]}
  ]
  dish_names.each do |dish_name|
    region = dish_name.keys[0]
    dishes_array = dish_name.values[0]
    dishes_array.each do |dish|
      wiki_page = Wikipedia.find(dish)
      dish_url = 'https://en.wikipedia.org/w/api.php?action=query&titles=' + dish + '&generator=images&gimlimit=10&prop=imageinfo&iiprop=url|dimensions|mime&format=json'
      uri = URI(dish_url)
      response = Net::HTTP.get(uri)
      json = JSON.parse(response)
      keys = json["query"]["pages"].keys
      images = []
      keys.each do |key|
        images << json["query"]["pages"]["#{key}"]["imageinfo"][0]["url"]
      end
      img_jpg_urls = images.select {|img| img.include?(".JPG") || img.include?(".jpg")}
      img_jpg_urls << "https://loremflickr.com/320/240/#{dish.split.join(",")}"
      byebug
    end
  end
end


find_images
