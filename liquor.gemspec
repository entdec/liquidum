$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'liquor/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'liquor'
  spec.version     = Liquor::VERSION
  spec.authors     = ['Tom de Grunt']
  spec.email       = ['tom@degrunt.nl']
  spec.homepage    = 'https://coden.entropydecelerator.com/components/liquor'
  spec.summary     = 'Liquid templating - on steroids'
  spec.description = 'Ready made set of tags, parsings and awesomeness'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'commonmarker', '~> 0.17.4'
  spec.add_dependency 'liquid', '~> 4.0.0'
  spec.add_dependency 'parslet'
  spec.add_dependency 'pg'
  spec.add_dependency 'rails', '~> 5'
  spec.add_dependency 'slim-rails', '~> 3.2.0'

  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'minitest-reporters', '~> 1.1'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-rails', '~> 0.3'
  spec.add_development_dependency 'rubocop', '~> 0.60'
end
