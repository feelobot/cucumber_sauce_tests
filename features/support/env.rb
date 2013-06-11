require 'rubygems'
require 'cucumber'
require 'selenium-webdriver'
require 'parallel'
require 'rspec'
require 'sauce'
require "sauce_whisk"

Sauce.config do |c|
  c[:browser] = "Chrome"
  c[:browser_version] = nil
  c[:os] = "OS X 10.8"
end

def environment
  env = ENV['ENV'] || "4"
  case env
  when "1"
    STAG1
  when "2"
    STAG2
  when "3"
    STAG3
  when "4"
    STAG4
  when "prod"
    PROD
  else 
    raise "Undefined environment"
  end
end

Before do |scenario|
  feature_name = scenario.feature.name + ": " + scenario.name
  $driver = Sauce::Selenium2.new(:name=>feature_name)
  $driver.navigate.to(environment)
  $wait = Selenium::WebDriver::Wait.new(:timeout => 30)
  $long_wait = Selenium::WebDriver::Wait.new(:timeout => 90)
  $hr = "#" * 70
end

After do |scenario| 
SauceWhisk::Jobs.change_status $driver.session_id, !scenario.failed?
$driver.quit 
end