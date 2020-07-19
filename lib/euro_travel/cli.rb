#require 'pry'
require "./lib/environment"

class EuroTravel::CLI
  
    def call
        make_countries
        country_list
    end

    def make_countries
        #use scraper class
        html = EuroTravel::Euro_travel_parser.new.open_site("Austria")
        list = EuroTravel::Euro_travel_parser.new.country_list(html)

        #use country class
        EuroTravel::Country.make_from_country_list(list)
    end

    def country_list
        puts ""
        puts "Welcome to the EU Travel Browser!"
        puts ""
        puts "What country would you like to look up?"
        puts ""
        EuroTravel::Country.all.each {|country| puts country.name}
        puts ""
        @country_input = gets.strip
        puts ""
        puts "What information would you like to know about #{@country_input}?"
        main_menu
    end

    def main_menu
        puts ""
        puts "1. Is #{@country_input} open to foreign tourists"
        puts "2. Does #{@country_input} require a quarantine period after entering"
        puts "3. Does #{@country_input} require a medical certificate to enter"
        puts ""

        main_input = gets.strip.to_i
        control_flow(main_input)
    end

    def back_to_menu
        puts ""
        puts "What would you like to do now?"
        puts "1. Main Menu"
        puts "2. Exit"
        puts ""

        back_input = gets.strip.to_i
        if back_input == 1
            country_list
        else
            puts ""
            puts "Have a nice day!"
        end
    end

    def control_flow(input)
        
        selected = EuroTravel::Country.all.select {|country| country.name == @country_input}
        selected[0].load_data

        if input == 1
            puts ""
                if selected[0].open == "indicator green"
                    puts "yes - #{@country_input} is open to foreign tourists"
                    puts selected[0].updated
                elsif selected[0].open == "indicator yellow"
                    puts "potential restrictions exist - check #{@country_input} travel site for more details"
                    puts selected[0].updated
                elsif selected[0].open == "indicator red"
                    puts "no - #{@country_input} is closed to foreign tourists"
                    puts selected[0].updated
                end
            back_to_menu

        elsif input == 2 
            puts ""
                if selected[0].quarantine == "indicator green"
                    puts "no - #{@country_input} does not require a quarantine"
                    puts selected[0].updated
                elsif selected[0].quarantine == "indicator yellow"
                    puts "potential restrictions exist - check #{@country_input} travel site for more details"
                    puts selected[0].updated
                elsif selected[0].quarantine == "indicator red"
                    puts "yes - #{@country_input} requires a mandatory quarantine for foreign tourists"
                    puts selected[0].updated
                end
            back_to_menu

        elsif input == 3
            puts ""
                if selected[0].medcert == "indicator green"
                    puts "no - #{@country_input} does not require a medical certificate"
                    puts selected[0].updated
                elsif selected[0].medcert == "indicator yellow"
                    puts "potential restrictions exist - check #{@country_input} travel site for more details"
                    puts selected[0].updated
                elsif selected[0].medcert == "indicator red"
                    puts "yes - #{@country_input} requires a medical certificate in order to enter"
                    puts selected[0].updated
                end
            back_to_menu
        end
    end
end
