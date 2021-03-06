# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
require 'wikipedia'

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Restaurant.destroy_all
Dish.destroy_all


def find_2km_restaurants
  uri_postcode = URI("https://api.postcodes.io/postcodes/ec2a1nt")
  postcode_response = Net::HTTP.get(uri_postcode)
  @postcode = JSON.parse(postcode_response)
  geounits = "#{@postcode["result"]["latitude"]},#{@postcode["result"]["longitude"]}"
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{geounits}&radius=30000&type=restaurant&keyword=chinese&key=AIzaSyAWHIVYglIX-UITv9CS6aXjTkrfL7Zm200"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  google_results = JSON.parse(response)
  info_hash = []
  google_results["results"].each_with_index do |restaurant_hash, index|
    results = Geocoder.search(restaurant_hash["vicinity"])
    if results.empty?
      postcode = 0
    else
      postcode = results.first.postal_code
    end
    info_hash << [restaurant_hash["name"], restaurant_hash["vicinity"], postcode]
  end
  info_hash
end

restaurants_data = find_2km_restaurants.select {|restaurant| restaurant[2].to_s.length > 4}

restaurants_data.each do |restaurant|
  Restaurant.create(name: restaurant[0], address: restaurant[1], postcode: restaurant[2])
end

User.create([
  {name: "Ritz Wu", username: "rizulol", password: "xoxo", postcode: "SE1 7LH", admin: true},
  {name: "Adham Muhammad", username: "adham_eats", password: "xoxo", postcode: "SW16 1AA", admin: true},
  {name: "Sarah Jacobs", username: "sarah_eats", password: "xoxo", postcode: "N15 5PX"},
  {name: "Steven Balasta", username: "steven_eats", password: "xoxo", postcode: "EC2Y 1NT"},
  {name: "Maduri Vassaramo", username: "maduri_eats", password: "xoxo", postcode: "N5 5EH"}
  ])

Restaurant.create(name: "My Old Place", address: "88-90 Middlesex St, London", postcode: "E1 7EZ", phone_number: '020 72472200')
Restaurant.create(name: "My Old Place", address: "88-90 Middlesex St, London", postcode: "E1 7EZ", phone_number: '020 72472200')
Restaurant.create(name: "Taste of China", address: "53 Hackney Rd, London", postcode: " E2 7NX", phone_number: '020 77391228')
Restaurant.create(name: "Ming Pat", address: "11 Cropley St, Islington, London", postcode: "N1 7PT", phone_number: '020 72501868')
Restaurant.create(name: "Kung Food", address: "126A Middlesex St, Whitechapel, London", postcode: "E1 7HY", phone_number: '020 72471088')
Restaurant.create(name: "Sam's Chinese Express", address: "61 Red Lion St, Holborn, London", postcode: "WC1R 4PD", phone_number: nil)

dish_names = [{"Sichuan" => ["Kung Pao chicken", "Hot and sour soup"]},
{"Guangdong" => ["Chow mein", "Chop suey", "Shrimp toast"]},
{"Taiwan" => ["Pork ball", "Yi mein"]},
{"Beijing" => ["Peking duck", "Spring roll", "Stir-fried tomato and scrambled eggs", "Moo shu pork"]} ]

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
    Dish.create(name: dish, description: wiki_page.summary, region: region, photo_1: img_jpg_urls[1], photo_2: img_jpg_urls[2], photo_3: img_jpg_urls.last)
  end
end
