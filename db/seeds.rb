# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
require 'wikipedia'

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Restaurant.destroy_all
Dish.destroy_all


User.create([
  {name: "Ritz Wu", username: "rizulol", password: "xoxo", postcode: "SE1 7LH"},
  {name: "Adham Muhammad", username: "adham_eats", password: "xoxo", postcode: "SW16 1AA"},
  {name: "Sarah Jacobs", username: "sarah_eats", password: "xoxo", postcode: "N15 5PX"},
  {name: "Steven Balasta", username: "steven_eats", password: "xoxo", postcode: "EC2Y 1NT"},
  {name: "Maduri Vassaramo", username: "maduri_eats", password: "xoxo", postcode: "N5 5EH"}
  ])

Restaurant.create(name: "My Old Place", address: "88-90 Middlesex St, London", postcode: "E1 7EZ", phone_number: '020 72472200')
Restaurant.create(name: "Taste of China", address: "53 Hackney Rd, London", postcode: " E2 7NX", phone_number: '020 77391228')
Restaurant.create(name: "Ming Pat", address: "11 Cropley St, Islington, London", postcode: "N1 7PT", phone_number: '020 72501868')
Restaurant.create(name: "Kung Food", address: "126A Middlesex St, Whitechapel, London", postcode: "E1 7HY", phone_number: '020 72471088')
Restaurant.create(name: "Sam's Chinese Express", address: "61 Red Lion St, Holborn, London", postcode: "WC1R 4PD", phone_number: nil)

dish_names = [{"Sichuan" => ["Kung Pao chicken", "Hot and sour soup"]}, {"Guangdong" => ["Chow mein", "Chop suey"]}, {"Guangzhou" => ["Shrimp toast"]} ]

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
    Dish.create(name: dish, description: wiki_page.summary, region: region, photo_1: img_jpg_urls.first, photo_2: img_jpg_urls.last)
    img_jpg_urls << "https://loremflickr.com/320/240/#{dish.split.join(",")}"
    Dish.create(name: dish, description: wiki_page.summary, region: region, photo_1: img_jpg_urls[1], photo_2: img_jpg_urls[2], photo_3: img_jpg_urls.last)
  end
end
