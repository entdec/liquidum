# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "liquidum/version"

Gem::Specification.new do |spec|
  spec.name = "liquidum"
  spec.version = Liquidum::VERSION

  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=
  spec.require_paths = ["lib"]
  spec.authors = ["Tom de Grunt"]
  spec.description = "Ready made set of tags, parsings and awesomeness"
  spec.email = ["tom@degrunt.nl"]
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.homepage = "https://github.com/entdec/liquidum"
  spec.licenses = ["MIT"]
  spec.summary = "Liquid templating - on steroids"

  spec.installed_by_version = "3.1.6" if spec.respond_to? :installed_by_version

  spec.add_runtime_dependency("addressable", ["~> 2"])
  spec.add_runtime_dependency("babel-transpiler", ["~> 0.7"])
  spec.add_runtime_dependency("i18n", ["~> 1.8"])
  spec.add_runtime_dependency("kramdown", ["~> 2.1"])
  spec.add_runtime_dependency("kramdown-parser-gfm", ["~> 1.0"])
  spec.add_runtime_dependency("liquid", ["~> 5.1"])
  spec.add_runtime_dependency("parslet", [">= 0"])
  spec.add_runtime_dependency("pg", [">= 0"])
  spec.add_runtime_dependency("rails", [">= 5.2"])
  spec.add_runtime_dependency("sassc", ["~> 2.2"])
  spec.add_runtime_dependency "slim-rails", "~> 3.6"
  spec.add_development_dependency("minitest", ["~> 5.11"])
  spec.add_development_dependency("minitest-reporters", ["~> 1.1"])
  spec.add_development_dependency("pry", ["> 0"])
  spec.add_development_dependency("pry-rails", ["~> 0.3"])
  spec.add_development_dependency "rubocop", "~> 1"

  spec.add_development_dependency "standard", "~> 1"
end
