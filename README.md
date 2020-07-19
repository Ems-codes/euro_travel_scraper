# EuroTravel

Welcome to the EuroTravel scraper. This app accesses information from the Re-open EU travel site and provides up to date information on the current travel restrictions within the European continent as countries reopen during the Covid-19 pandemic. Users can interact with this information through a CLI. 

## Installation

    $ gem install euro_travel

## Usage

run "ruby bin/euro_travel" to begin using app 
For Windows WSL:Ubuntu users: 
    - install chromedriver to your local device https://chromedriver.chromium.org/
    - update the URL in the euro_travel_parser class on line 16  if needed
    - run chromedriver through your local windows command line to connect with WSL:Ubuntu

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/euro_travel.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
