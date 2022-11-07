# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'liquidum/version'

Gem::Specification.new do |s|
  s.name = 'liquidum'
  s.version = Liquidum::VERSION

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.require_paths = ['lib']
  s.authors = ['Tom de Grunt']
  s.date = '2021-11-18'
  s.description = 'Ready made set of tags, parsings and awesomeness'
  s.email = ['tom@degrunt.nl']
  s.files = ['MIT-LICENSE', 'README.md', 'Rakefile',
             'app/controllers/liquidum', 'app/controllers/liquidum/application_controller.rb', 'app/controllers/liquidum/completions_controller.rb', 'app/controllers/liquidum/sandbox_controller.rb', 'app/helpers/liquidum', 'app/helpers/liquidum/application_helper.rb', 'app/jobs/liquidum', 'app/jobs/liquidum/application_job.rb', 'app/models/concerns', 'app/models/concerns/liquidum', 'app/models/concerns/liquidum/to_liquid.rb', 'app/views/liquidum', 'app/views/liquidum/sandbox', 'app/views/liquidum/sandbox/index.html.slim', 'config/routes.rb', 'lib/liquidum', 'lib/liquidum.rb', 'lib/liquidum/configuration.rb', 'lib/liquidum/drop.rb', 'lib/liquidum/engine.rb', 'lib/liquidum/liquid', 'lib/liquidum/liquid/drops', 'lib/liquidum/liquid/drops/active_storage_attached_many_drop.rb', 'lib/liquidum/liquid/drops/active_storage_attached_one_drop.rb', 'lib/liquidum/liquid/drops/active_storage_attachment_drop.rb', 'lib/liquidum/liquid/drops/enumerator_lazy_drop.rb', 'lib/liquidum/liquid/filters', 'lib/liquidum/liquid/filters/encode_filter.rb', 'lib/liquidum/liquid/filters/format_filter.rb', 'lib/liquidum/liquid/filters/localize_filter.rb', 'lib/liquidum/liquid/filters/strptime_filter.rb', 'lib/liquidum/liquid/filters/array_wrap_filter.rb', 'lib/liquidum/liquid/filters/sum_filter.rb', 'lib/liquidum/liquid/filters/timezone_filter.rb', 'lib/liquidum/liquid/filters/to_filter.rb', 'lib/liquidum/liquid/filters/translate_filter.rb', 'lib/liquidum/liquid/filters/where_exp_filter.rb', 'lib/liquidum/liquid/liquid_helpers.rb', 'lib/liquidum/liquid/liquid_template_extensions.rb', 'lib/liquidum/liquid/liquidum_block.rb', 'lib/liquidum/liquid/liquidum_tag.rb', 'lib/liquidum/liquid/parser.rb', 'lib/liquidum/liquid/tags', 'lib/liquidum/liquid/tags/helper_tag.rb', 'lib/liquidum/liquid/tags/render_tag.rb', 'lib/liquidum/version.rb']
  s.homepage = 'https://github.com/entdec/liquidum'
  s.licenses = ['MIT']
  s.rubygems_version = '3.1.6'
  s.summary = 'Liquid templating - on steroids'

  s.installed_by_version = '3.1.6' if s.respond_to? :installed_by_version

  s.specification_version = 4 if s.respond_to? :specification_version

  if s.respond_to? :add_runtime_dependency
    s.add_runtime_dependency('addressable', ['~> 2'])
    s.add_runtime_dependency('babel-transpiler', ['~> 0.7'])
    s.add_runtime_dependency('i18n', ['~> 1.8'])
    s.add_runtime_dependency('kramdown', ['~> 2.1'])
    s.add_runtime_dependency('kramdown-parser-gfm', ['~> 1.0'])
    s.add_runtime_dependency('liquid', ['= 5.1.0'])
    s.add_runtime_dependency('parslet', ['>= 0'])
    s.add_runtime_dependency('pg', ['>= 0'])
    s.add_runtime_dependency('rails', ['>= 5.2'])
    s.add_runtime_dependency('sassc', ['~> 2.2'])
    s.add_runtime_dependency('slim-rails', ['~> 3.2.0'])
    s.add_development_dependency('auxilium', ['~>3'])
    s.add_development_dependency('minitest', ['~> 5.11'])
    s.add_development_dependency('minitest-reporters', ['~> 1.1'])
    s.add_development_dependency('pry', ['>= 0'])
    s.add_development_dependency('pry-rails', ['~> 0.3'])
    s.add_development_dependency('rubocop', ['~> 1'])
  else
    s.add_dependency('addressable', ['~> 2'])
    s.add_dependency('auxilium', ['~> 3'])
    s.add_dependency('babel-transpiler', ['~> 0.7'])
    s.add_dependency('i18n', ['~> 1.8'])
    s.add_dependency('kramdown', ['~> 2.1'])
    s.add_dependency('kramdown-parser-gfm', ['~> 1.0'])
    s.add_dependency('liquid', ['= 5.1.0'])
    s.add_dependency('minitest', ['~> 5.11'])
    s.add_dependency('minitest-reporters', ['~> 1.1'])
    s.add_dependency('parslet', ['>= 0'])
    s.add_dependency('pg', ['>= 0'])
    s.add_dependency('pry', ['>= 0'])
    s.add_dependency('pry-rails', ['~> 0.3'])
    s.add_dependency('rails', ['>= 5.2'])
    s.add_dependency('rubocop', ['~> 1'])
    s.add_dependency('sassc', ['~> 2.2'])
    s.add_dependency('slim-rails', ['~> 3.2.0'])
  end
end
