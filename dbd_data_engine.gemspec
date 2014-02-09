lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem's version:
require "dbd_data_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'dbd_data_engine'
  s.version     = DbdDataEngine::VERSION
  s.authors     = ['Peter Vandenabeele']
  s.email       = ['peter@vandenabeele.com']
  s.homepage    = 'https://github.com/petervandenabeele/dbd_data_engine'
  s.summary     = 'Edit data in dbd as part of a web app.'
  s.description = 'A Rails engine that allows edit data dbd.'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_dependency 'rails', '>= 4.0.2'
  s.add_dependency 'haml'
  s.add_dependency 'dbd', '~> 0.1.3'
  s.add_dependency 'dbd_onto', '~> 0.0.13'

  s.add_development_dependency 'haml-rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'terminal-notifier-guard'
  s.add_development_dependency 'capybara'
end
