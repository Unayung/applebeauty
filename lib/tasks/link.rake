# -*- encoding : utf-8 -*-
require 'nokogiri'
require 'open-uri'

namespace :link do

  task :get_all_link => :environment do

    apple_url = 'http://www.appledaily.com.tw/appledaily/bloglist/headline/30342177/'
    i = 1
    while i < 11
      list = Nokogiri::HTML(open(apple_url+i.to_s))
      list = list.css('div.abdominis')
      list.css('li.fillup a').each do |link|
        
        l = Link.new
        l.url = "http://www.appledaily.com.tw"+link['href']
        l.title = link.content
        page_url = URI::encode(l.url)
        page = Nokogiri::HTML(open(page_url))
        image = page.css('div.articulum > figure > a')
        l.remote_photo_url = image.attr('href').value
        l.save
        
      end
      i +=1
    end
    
  end

end
