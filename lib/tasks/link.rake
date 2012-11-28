# -*- encoding : utf-8 -*-
require 'nokogiri'
require 'open-uri'

namespace :link do

  task :get_all_link => :environment do
    apple_url = 'http://www.appledaily.com.tw/appledaily/bloglist/headline/30342177/'
    i = 1
    while i < 10
      list = Nokogiri::HTML(open(apple_url+i.to_s))
      list = list.css('div.abdominis')
      list.css('li.fillup').each do |link|
        l = Link.new
        l.url = "http://www.appledaily.com.tw"+link.css('a').attr('href')
        l.title = link.css('time').text
        page_url = URI::encode(l.url)
        page = Nokogiri::HTML(open(page_url))
        image = page.css('div.articulum > figure > a')
        video = page.css('script').text.match(/http.*\.mp4/)
        text = page.css('p#introid').inner_html
        if video
          l.clip = video[0]
          l.detail = text
          photo = Photo.new
          photo.remote_file_url = image.attr('href').value
          l.save
          photo.link_id = l.id
          photo.save
        end 
      end
      i +=1
    end
  end

  task :get_new_link => :environment do
    apple_url = 'http://www.appledaily.com.tw/appledaily/bloglist/headline/30342177/1'
    list = Nokogiri::HTML(open(apple_url))
    list = list.css('div.abdominis')
    link = list.css('li.fillup').first
    
    l = Link.new
    l.url = "http://www.appledaily.com.tw"+link.css('a').attr('href')
    l.title = link.css('time').text
    page_url = URI::encode(l.url)
    page = Nokogiri::HTML(open(page_url))
    image = page.css('div.articulum > figure > a')
    video = page.css('script').text.match(/http.*\.mp4/)
    text = page.css('p#introid').inner_html
    if video
      l.clip = video[0]
      l.detail = text
      photo = Photo.new
      photo.remote_file_url = image.attr('href').value
      l.save
      photo.link_id = l.id
      photo.save
    end 
    
  end

end
