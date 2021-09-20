# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'liquor/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'liquor'
  spec.version     = Liquor::VERSION
  spec.authors     = ['Tom de Grunt']
  spec.email       = ['tom@degrunt.nl']
  spec.homepage    = 'https://code.entropydecelerator.com/components/liquor'
  spec.summary     = 'Liquid templating - on steroids'
  spec.description = 'Ready made set of tags, parsings and awesomeness'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'babel-transpiler', '~> 0.7'

  spec.add_dependency 'addressable', '~> 2'
  spec.add_dependency 'i18n', '~> 1.8'
  spec.add_dependency 'kramdown', '~> 2.1'
  spec.add_dependency 'kramdown-parser-gfm', '~> 1.0'
  spec.add_dependency 'liquid', '~> 5.0'
  spec.add_dependency 'parslet'
  spec.add_dependency 'pg'
  spec.add_dependency 'rails', '>= 5.2'
  spec.add_dependency 'sassc', '~> 2.2'
  spec.add_dependency 'slim-rails', '~> 3.2.0'

  spec.add_development_dependency 'auxilium', '~> 0.2'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'minitest-reporters', '~> 1.1'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-rails', '~> 0.3'
  spec.add_development_dependency 'rubocop', '~> 1'
end
