# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'liquor/version'

Gem::Specification.new do |s|
  s.name = 'liquor'
  s.version = Liquor::VERSION

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.require_paths = ['lib']
  s.authors = ['Tom de Grunt']
  s.date = '2021-11-18'
  s.description = 'Ready made set of tags, parsings and awesomeness'
  s.email = ['tom@degrunt.nl']
  s.files = ['MIT-LICENSE', 'README.md', 'Rakefile',
             'app/assets/config/liquor_manifest.js', 'app/assets/images/liquor', 'app/assets/javascripts', 'app/assets/javascripts/liquor', 'app/assets/javascripts/liquor/application.js', 'app/assets/stylesheets/liquor', 'app/assets/stylesheets/liquor/application.css', 'app/controllers/liquor', 'app/controllers/liquor/application_controller.rb', 'app/controllers/liquor/completions_controller.rb', 'app/controllers/liquor/sandbox_controller.rb', 'app/helpers/liquor', 'app/helpers/liquor/application_helper.rb', 'app/jobs/liquor', 'app/jobs/liquor/application_job.rb', 'app/mailers', 'app/mailers/liquor', 'app/mailers/liquor/application_mailer.rb', 'app/models/concerns', 'app/models/concerns/liquor', 'app/models/concerns/liquor/to_liquid.rb', 'app/models/liquor', 'app/models/liquor/application_record.rb', 'app/views/liquor', 'app/views/liquor/sandbox', 'app/views/liquor/sandbox/index.html.slim', 'config/routes.rb', 'lib/liquor', 'lib/liquor.rb', 'lib/liquor/configuration.rb', 'lib/liquor/drop.rb', 'lib/liquor/engine.rb', 'lib/liquor/liquid', 'lib/liquor/liquid/drops', 'lib/liquor/liquid/drops/active_storage_attached_many_drop.rb', 'lib/liquor/liquid/drops/active_storage_attached_one_drop.rb', 'lib/liquor/liquid/drops/active_storage_attachment_drop.rb', 'lib/liquor/liquid/drops/enumerator_lazy_drop.rb', 'lib/liquor/liquid/filters', 'lib/liquor/liquid/filters/encode_filter.rb', 'lib/liquor/liquid/filters/format_filter.rb', 'lib/liquor/liquid/filters/localize_filter.rb', 'lib/liquor/liquid/filters/strptime_filter.rb', 'lib/liquor/liquid/filters/array_wrap_filter.rb', 'lib/liquor/liquid/filters/sum_filter.rb', 'lib/liquor/liquid/filters/timezone_filter.rb', 'lib/liquor/liquid/filters/to_filter.rb', 'lib/liquor/liquid/filters/translate_filter.rb', 'lib/liquor/liquid/filters/where_exp_filter.rb', 'lib/liquor/liquid/liquid_helpers.rb', 'lib/liquor/liquid/liquid_template_extensions.rb', 'lib/liquor/liquid/liquor_block.rb', 'lib/liquor/liquid/liquor_tag.rb', 'lib/liquor/liquid/parser.rb', 'lib/liquor/liquid/tags', 'lib/liquor/liquid/tags/helper_tag.rb', 'lib/liquor/liquid/tags/render_tag.rb', 'lib/liquor/version.rb']
  s.homepage = 'https://github.com/entdec/liquor'
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
    s.add_development_dependency('auxilium', ['~> 0.2'])
    s.add_development_dependency('minitest', ['~> 5.11'])
    s.add_development_dependency('minitest-reporters', ['~> 1.1'])
    s.add_development_dependency('pry', ['>= 0'])
    s.add_development_dependency('pry-rails', ['~> 0.3'])
    s.add_development_dependency('rubocop', ['~> 1'])
  else
    s.add_dependency('addressable', ['~> 2'])
    s.add_dependency('auxilium', ['~> 0.2'])
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
