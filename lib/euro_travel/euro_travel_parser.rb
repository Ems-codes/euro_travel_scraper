require "./lib/environment"
require 'open-uri'
require 'nokogiri'
require 'capybara'
require 'webdrivers'
#require 'pry'

class EuroTravel::Euro_travel_parser

    def run_capybara
    # Creates a chrome browser instance and instantiates Capybara 

      Capybara.register_driver :windows_chrome do |app|
        capabilities = Selenium::WebDriver::Remote::Capabilities.chrome()
        puts 'Current driver (windows_chrome) requires chromedriver to be launched from windows (C:\Users\Emily\OneDrive\Desktop\chromedriver)'
        Capybara::Selenium::Driver.new(app,browser: :chrome, url: 'http://localhost:9515',
                                           desired_capabilities: capabilities)
      end

      Capybara.default_driver = :windows_chrome
      Capybara.javascript_driver = :windows_chrome
      Capybara.default_max_wait_time = 15 # Seconds
      Selenium::WebDriver.logger.level = :debug
      Webdrivers.logger.level = :DEBUG

    end

    def open_site(country_name_input)
    # Opens "https://reopen.europa.eu/en/map" with country name and closes pop-ups on page to allow access to HTML
          
      run_capybara
      browser = Capybara.current_session

      #load url file
      file = File.open("/home/ems_codes/code/labs/euro_travel/bin/urls.txt")
      file_array = file.read.split("\n")  
      url_map = file_array.each_with_object({}){|country,hash| hash[country.split(" - ")[0]] = country.split(" - ")[1]}
      url = url_map[country_name_input]

      #open site in browser, closes pop-ups to get to clean HTML
      browser.visit url
      links = browser.all 'div a'
      links[2].click 
      browser.find_button('Close').click
      html = browser.html
      browser.quit

      #return the html source code for Nokogiri
      html

    end
    
    def scrape_site(source_html)

      doc = Nokogiri::HTML(source_html)  
      country_hash = {}
      
        #Nokogiri scraping for status of countries
        indicator_information = doc.css(".indicators")
        data = indicator_information.css("button")
        country = doc.css(".ecl-select").text.strip

        country_hash[country] = data.each_with_object({}) {|param, hash| 
          hash[param.attribute("aria-label").text] = param.attribute("class").text
        }

        #Nokogiri scraping for date updated
        country_hash["date_updated"] = doc.css(".updated").text

      country_hash

    end

    def country_list(source_html)

      doc = Nokogiri::HTML(source_html) 
      names_array = []

        #Nokogiri scraping for full country list
        country_information = doc.css(".search")
        country_list = country_information.css("div")[4].css("button")
        names_array = country_list.collect{|field| field.text}

      names_array

    end

end


