require 'wikipedia'
require 'byebug'

require 'net/http'
require 'json'

# url = 'https://developers.zomato.com/api/v2.1/search?entity_id=61&entity_type=city&cuisines=25&establishment_type=21'
dish = "Chop suey"
dish_url = 'https://en.wikipedia.org/w/api.php?action=query&titles=' + dish + '&generator=images&gimlimit=10&prop=imageinfo&iiprop=url|dimensions|mime&format=json'
uri = URI(dish_url)
response = Net::HTTP.get(uri)
json = JSON.parse(response)
image_url = json["query"]["pages"]["-1"]["imageinfo"][0]["url"]

keys = json["query"]["pages"].keys
images = []
keys.each do |key|
  images << json["query"]["pages"]["#{key}"]["imageinfo"][0]["url"]
end
img_jpg_urls = images.select {|img| img.include?(".JPG") || img.include?(".jpg")}

byebug

wiki_page = Wikipedia.find('Hot and sour soup')
byebug
puts wiki_page.images
