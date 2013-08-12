$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dbd_data_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dbd_data_engine"
  s.version     = DbdDataEngine::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of DbdDataEngine."
  s.description = "TODO: Description of DbdDataEngine."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.0"
end
