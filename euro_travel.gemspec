require_relative 'lib/euro_travel/version'

Gem::Specification.new do |spec|
  spec.name          = "euro_travel"
  spec.version       = EuroTravel::VERSION
  spec.authors       = ["ems_codes"]
  spec.email         = ["emilyxi@gmail.com"]

  spec.summary       = %q{euro_travel scraper tool}
  spec.description   = %q{finds information on travel during covid-19}
  spec.homepage      = "http://bob.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://bob.com"
  spec.metadata["changelog_uri"] = "http://bob.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
