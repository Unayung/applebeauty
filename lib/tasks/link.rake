# -*- encoding : utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

module LinkMethods
  include Capybara::DSL

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

  def self.generate_link_from_links_by_capybara(links)
    capybara_initialize
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
        @session.visit(page_url)
        file = @session.save_page
        txt = File.read(file)
        clip_url = txt.scan(/\"streams\".*.mp4/)[0].scan(/https.*mp4/)[0]
        image_url = txt.scan(/\"originalName.*.jpg.*originalUrl/)[0].scan(/https.*.jpg/)[0]
        metas = @session.all('meta', visible: false)
        metas.each do |meta|
          @description = meta[:content] if meta[:name] == 'description'
        end
        l.clip = clip_url
        l.detail = @description
        photo = Photo.new
        puts image_url
        photo.remote_file_url = image_url
        l.save
        photo.link_id = l.id
        photo.save
      end
    end
  end

  def self.capybara_initialize
    phantomjs_options = [
        '--load-images=yes',
        '--ignore-ssl-errors=yes',
        '--ssl-protocol=any',
        '--web-security=false'
    ]
    driver_options = {
        timeout: 120,
        js_errors: false,
        phantomjs_options: phantomjs_options
    }
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, driver_options)
    end
    
    Capybara.javascript_driver = :poltergeist
    Capybara.current_driver = :poltergeist
    Capybara.threadsafe = true
    @session = Capybara::Session.new(:poltergeist)
    @session.driver.headers =
    {
      "user-agent": 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Safari/604.1.38',
      "accept-language": 'zh-tw'
    }
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
    LinkMethods.generate_link_from_links_by_capybara(links)
  end

  task :get_new_link => :environment do
    apple_url = 'https://tw.appledaily.com/appledaily/bloglist/headline/30342177'
    list = LinkMethods.get_list_from_url(apple_url)
    links = LinkMethods.extract_links_from_list(list)
    LinkMethods.generate_link_from_links_by_capybara([links.first])
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
