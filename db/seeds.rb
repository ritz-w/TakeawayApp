# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
require 'wikipedia'

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Restaurant.destroy_all
Dish.destroy_all

User.create(name: "Ritz Wu", username: "rizulol", postcode: "SE1 7LH")
User.create(name: "Adham Muhammad", username: "adham_eats", postcode: "SW16 1AA")
User.create(name: "Sarah Jacobs", username: "sarah_eats", postcode: "N15 5PX")
User.create(name: "Steven Balasta", username: "steven_eats", postcode: "EC2Y 1NT")
User.create(name: "Maduri Vassaramo", username: "maduri_eats", postcode: "N5 5EH")

Restaurant.create(name: "My Old Place", address: "88-90 Middlesex St, London", postcode: "E1 7EZ", rating: 0, phone_number: '020 72472200')
Restaurant.create(name: "Taste of China", address: "53 Hackney Rd, London", postcode: " E2 7NX", rating: 0, phone_number: '020 77391228')
Restaurant.create(name: "Ming Pat", address: "11 Cropley St, Islington, London", postcode: "N1 7PT", rating: 0, phone_number: '020 72501868')
Restaurant.create(name: "Kung Food", address: "126A Middlesex St, Whitechapel, London", postcode: "E1 7HY", rating: 0, phone_number: '020 72471088')
Restaurant.create(name: "Sam's Chinese Express", address: "61 Red Lion St, Holborn, London", postcode: "WC1R 4PD", rating: 0, phone_number: nil)

dish_names = [{"Sichuan" => ["Kung Pao chicken", "Hot and sour soup"]}, {"Guangdong" => ["Chow mein", "Chop suey"]}, {"Guangzhou" => ["Shrimp toast"]} ]

dish_names.each do |dish_name|
  region = dish_name.keys[0]
  dishes_array = dish_name.values[0]
  dishes_array.each do |dish|
    wiki_page = Wikipedia.find(dish)
    imgs = wiki_page.images.select {|img| img.include?(".JPG") || img.include?(".jpg")}
    img_links = wiki_page.image_urls.select {|url| url}
    Dish.create(name: dish, description: wiki_page.summary, region: region, rating: 0, img_url: img_links.join(","), photo_1: imgs.first, photo_2: imgs.last)
  end
end
