require 'capybara'
require 'capybara-screenshot'
require "selenium/webdriver"
require 'pry'
require 'open-uri'

url = ENV['URL'] || 'https://www.manhuagui.com/comic/25819/'
Manga.capybara_init
Manga.run(url)

module Manga
  def self.capybara_init
    Capybara.register_driver :headless_chrome do |app|
      Capybara::Selenium::Driver.new app, browser: :chrome,
        options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu window-size=1440,5000])
    end

    Capybara.default_driver = :headless_chrome
    Capybara.javascript_driver = :headless_chrome
    @session = Capybara::Session.new(:headless_chrome)
  end

  def self.run(url)
    @session.visit url
    sleep 5
    title = @session.find('div.book-title > h1').text
    puts "作品：#{title}"
    puts '取得章節資料中 ...'
    list = @session.all('div.chapter-list').first
    visible_chapters = list.all('li', visible: true)
    invisible_chapters = list.all('li', visible: false)
    extract_pages(invisible_chapters)
    extract_pages(visible_chapters)
  end

  def self.extract_pages(chapters)
    pages = chapters.map {|c| {title: c.text, url: c.find('a')[:href]} }.reverse
    puts "總共 #{pages.size} 章"
    pages.each do |p|
      puts "Start grabbing #{p[:title]}"
      @urls = []
      @session.visit p[:url]
      sleep 3
      begin
        while !@urls.include?(@session.find('img#mangaFile')[:src])
          @urls << @session.find('img#mangaFile')[:src]
          sleep 2
          @session.find('img#mangaFile').click # 翻頁
        end
        @urls.each_with_index do |url, i|
          @session.visit url
          width, height = @session.driver.browser.title.scan(/\(.*\)/).first.split('×')[0].gsub('(','').to_i, @session.driver.browser.title.scan(/\(.*\)/).first.split('×')[1].gsub(')','').to_i
          @session.driver.resize_window_to(@session.windows.first.handle, width, height)
          @session.save_screenshot("./#{p[:title]}/#{i+1}.png")
        end
        puts "End of grabbing #{p[:title]}"
      rescue
        binding.pry
      end
    end  
  end
end