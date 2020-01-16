
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "SnowReport/version"

Gem::Specification.new do |spec|
  spec.name          = "SnowReport"
  spec.version       = SnowReport::VERSION
  spec.authors       = ["'Otto Cedeno'"]
  spec.email         = ["'otto@ottostacos.com'"]

  spec.summary       = %q{Provides a CLI application for users to see the the top ski mountains in the world.}
  spec.description   = %q{Snow Report allows users to see a list of the top mountains sorted by total snowfall.  Users can select a specific mountain to see additioanal details like trail and lift info.}
  spec.homepage      = "https://github.com/ottocedeno/snowreport"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
  #
  #   spec.metadata["homepage_uri"] = spec.homepage
  #   spec.metadata["source_code_uri"] = "Put your gem's public repo URL here."
  #   spec.metadata["changelog_uri"] = "Put your gem's CHANGELOG.md URL here."
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "colorize"
  spec.add_dependency "nokogiri"
end
