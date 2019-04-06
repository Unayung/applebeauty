# -*- encoding : utf-8 -*-
require 'nokogiri'
require 'open-uri'

module LinkMethods
  def self.get_list_from_url(url)
    page = Nokogiri::HTML(open(url))
    list = page.css('div.abdominis')
    list
  end

  def self.extract_links_from_list(list)
    links = []
    list.css('li.fillup').each do |link|
      links << {url: "https://tw.appledaily.com"+link.css('a').attr('href'), title: link.css('time').text.scan(/(\d+)/).flatten.join('-')}
    end
    links
  end

  def self.generate_link_from_links(links)
    links.each do |link|
      if Link.where(:title => link[:title]).size > 0
        puts "已抓"
      else
        l = Link.new
        l.url = link[:url]
        l.title = link[:title]
        puts l.title
        page_url = URI::encode(l.url)
        puts page_url
        page = Nokogiri::HTML(open(page_url))
        if page.css('div.ndAritcle_headPic > img').size > 0
          image = page.css('div.ndAritcle_headPic > img')
        else
          image = page.css('div.ndArticle_margin > figure > img')
        end
        video = page.css('div.thoracis').text.match(/http.*\.mp4/)
        text = page.css('div.ndArticle_margin > p').inner_html
        puts text
        if video
          l.clip = video[0]
        end
        l.detail = text
        photo = Photo.new
        puts image.attr('src').value
        photo.remote_file_url = image.attr('src').value
        l.save
        photo.link_id = l.id
        photo.save
      end
    end
  end
end

namespace :link do

  task :get_all_link => :environment do
    apple_url = 'https://tw.appledaily.com/appledaily/bloglist/headline/30342177'
    list = LinkMethods.get_list_from_url(apple_url)
    links = LinkMethods.extract_links_from_list(list)
    LinkMethods.generate_link_from_links(links)
  end

  task :get_new_link => :environment do
    apple_url = 'https://tw.appledaily.com/appledaily/bloglist/headline/30342177'
    list = LinkMethods.get_list_from_url(apple_url)
    links = LinkMethods.extract_links_from_list(list)
    LinkMethods.generate_link_from_links([links.first])
  end

  task :get_specific_link => :environment do
    if ENV['url'].present?
      apple_url = ENV['url']
      l = Link.new
      l.url = apple_url
      l.title = ENV['title']
      l.slug = ENV['title']
      puts l.title
      page_url = URI::encode(l.url)
      puts page_url
      page = Nokogiri::HTML(open(page_url))
      # binding.pry
      if page.css('div.ndAritcle_headPic > img').size > 0
        image = page.css('div.ndAritcle_headPic > img')
      else
        image = page.css('div.ndArticle_margin > figure > img')
      end
      video = page.css('div.thoracis').text.match(/http.*\.mp4/)
      text = page.css('div.ndArticle_margin > p').inner_html
      puts text
      if video
        l.clip = video[0]
      end
      l.detail = text
      photo = Photo.new
      puts image.attr('src').value
      photo.remote_file_url = image.attr('src').value
      l.save
      photo.link_id = l.id
      photo.save
    end
  end

end
