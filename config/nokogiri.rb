require 'nokogiri'
require 'open-uri'

list = Nokogiri::HTML(open('http://www.appledaily.com.tw/appledaily/bloglist/headline/30342177'))
list = list.css('div.abdominis')
list.css('li.fillup a').each do |link|
  puts link['href']
end