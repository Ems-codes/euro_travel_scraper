#require 'pry'
require "./lib/environment"

class EuroTravel::Country

    attr_accessor :open, :quarantine, :medcert, :updated
    attr_reader :name
    @@all = []

    def initialize(name)

        @name = name
        @@all << self
        
    end

    def load_data 
        
        #load scraper
        html = EuroTravel::Euro_travel_parser.new.open_site(@name)
        country_info = EuroTravel::Euro_travel_parser.new.scrape_site(html)
        
        #add data to country object
        country_info[@name].each_key {|key, value|
            if key.include?("third-country")
                self.send("open=", country_info[@name][key])
            elsif key.include?("quarantine")
                self.send("quarantine=", country_info[@name][key])
            elsif key.include?('medical certificate')
                self.send("medcert=", country_info[@name][key])
            end
        }

        self.send("updated=", country_info["date_updated"])

    end

    def self.make_from_country_list(scraper_list)
        
        scraper_list.each {|country|
            new_country = EuroTravel::Country.new(country)
        }

    end

    def self.all

        @@all

    end
    
end