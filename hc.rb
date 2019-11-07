# brew cask install chromedriver
# remove chromedrivers in rbenv
# test chromedriver with chromedriver -v

require 'capybara'
require 'capybara-screenshot'
require "selenium/webdriver"
require 'pry'

Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.new app, browser: :chrome,
    options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu window-size=1440,5000])
end

Capybara.default_driver = :headless_chrome
Capybara.javascript_driver = :headless_chrome

url = 'https://www.ubereats.com/zh-TW/'

@session = Capybara::Session.new(:headless_chrome)
@session.visit url
sleep 5
# @session.save_and_open_screenshot
puts @session.all('li a').map(&:text)

store_link = @session.all('li a').map { |a| a[:href] }[0]
@session.visit store_link
@session.save_and_open_screenshot

binding.pry
puts 'Finish!'