require 'wikipedia'
require 'byebug'

wiki_page = Wikipedia.find('Hot and sour soup')
byebug
puts wiki_page.images
