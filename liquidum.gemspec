# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'liquidum/version'

Gem::Specification.new do |spec|
  spec.name = 'liquidum'
  spec.version = Liquidum::VERSION

  spec.required_rubygems_version = Gem::Requirement.new('>= 0') if spec.respond_to? :required_rubygems_version=
  spec.require_paths = ['lib']
  spec.authors = ['Tom de Grunt']
  spec.date = '2021-11-18'
  spec.description = 'Ready made set of tags, parsings and awesomeness'
  spec.email = ['tom@degrunt.nl']
  spec.files = ['MIT-LICENSE', 'README.md', 'Rakefile',
                'app/controllers/liquidum', 'app/controllers/liquidum/application_controller.rb', 'app/controllers/liquidum/completions_controller.rb', 'app/controllers/liquidum/sandbox_controller.rb', 'app/helpers/liquidum', 'app/helpers/liquidum/application_helper.rb', 'app/jobs/liquidum', 'app/jobs/liquidum/application_job.rb', 'app/models/concerns', 'app/models/concerns/liquidum', 'app/models/concerns/liquidum/to_liquid.rb', 'app/views/liquidum', 'app/views/liquidum/sandbox', 'app/views/liquidum/sandbox/index.html.slim', 'config/routespec.rb', 'lib/liquidum', 'lib/liquidum.rb', 'lib/liquidum/configuration.rb', 'lib/liquidum/drop.rb', 'lib/liquidum/engine.rb', 'lib/liquidum/liquid', 'lib/liquidum/liquid/drops', 'lib/liquidum/liquid/drops/active_storage_attached_many_drop.rb', 'lib/liquidum/liquid/drops/active_storage_attached_one_drop.rb', 'lib/liquidum/liquid/drops/active_storage_attachment_drop.rb', 'lib/liquidum/liquid/drops/enumerator_lazy_drop.rb', 'lib/liquidum/liquid/filters', 'lib/liquidum/liquid/filters/encode_filter.rb', 'lib/liquidum/liquid/filters/format_filter.rb', 'lib/liquidum/liquid/filters/localize_filter.rb', 'lib/liquidum/liquid/filters/strptime_filter.rb', 'lib/liquidum/liquid/filters/array_wrap_filter.rb', 'lib/liquidum/liquid/filters/sum_filter.rb', 'lib/liquidum/liquid/filters/timezone_filter.rb', 'lib/liquidum/liquid/filters/to_filter.rb', 'lib/liquidum/liquid/filters/translate_filter.rb', 'lib/liquidum/liquid/filters/where_exp_filter.rb', 'lib/liquidum/liquid/liquid_helperspec.rb', 'lib/liquidum/liquid/liquid_template_extensionspec.rb', 'lib/liquidum/liquid/liquidum_block.rb', 'lib/liquidum/liquid/liquidum_tag.rb', 'lib/liquidum/liquid/parser.rb', 'lib/liquidum/liquid/tags', 'lib/liquidum/liquid/tags/helper_tag.rb', 'lib/liquidum/liquid/tags/render_tag.rb', 'lib/liquidum/version.rb']
  spec.homepage = 'https://github.com/entdec/liquidum'
  spec.licenses = ['MIT']
  spec.rubygems_version = '3.1.6'
  spec.summary = 'Liquid templating - on steroids'

  spec.installed_by_version = '3.1.6' if spec.respond_to? :installed_by_version

  spec.specification_version = 4 if spec.respond_to? :specification_version

  spec.add_runtime_dependency('addressable', ['~> 2'])
  spec.add_runtime_dependency('babel-transpiler', ['~> 0.7'])
  spec.add_runtime_dependency('i18n', ['~> 1.8'])
  spec.add_runtime_dependency('kramdown', ['~> 2.1'])
  spec.add_runtime_dependency('kramdown-parser-gfm', ['~> 1.0'])
  spec.add_runtime_dependency('liquid', ['= 5.1.0'])
  spec.add_runtime_dependency('parslet', ['>= 0'])
  spec.add_runtime_dependency('pg', ['>= 0'])
  spec.add_runtime_dependency('rails', ['>= 5.2'])
  spec.add_runtime_dependency('sassc', ['~> 2.2'])
  spec.add_runtime_dependency "slim-rails", "~> 3.6"
  spec.add_development_dependency('auxilium', ['~>3'])
  spec.add_development_dependency('minitest', ['~> 5.11'])
  spec.add_development_dependency('minitest-reporters', ['~> 1.1'])
  spec.add_development_dependency('pry', ['> 0'])
  spec.add_development_dependency('pry-rails', ['~> 0.3'])
  spec.add_development_dependency('rubocop', ['~> 1'])
end
