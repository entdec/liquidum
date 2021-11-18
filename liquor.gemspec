# stub: liquor 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = 'liquor'.freeze
  s.version = '1.0.4'

  s.required_rubygems_version = Gem::Requirement.new('>= 0'.freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ['lib'.freeze]
  s.authors = ['Tom de Grunt'.freeze]
  s.date = '2021-11-18'
  s.description = 'Ready made set of tags, parsings and awesomeness'.freeze
  s.email = ['tom@degrunt.nl'.freeze]
  s.files = ['MIT-LICENSE'.freeze, 'README.md'.freeze, 'Rakefile'.freeze,
             'app/assets/config/liquor_manifest.js'.freeze, 'app/assets/images/liquor'.freeze, 'app/assets/javascripts'.freeze, 'app/assets/javascripts/liquor'.freeze, 'app/assets/javascripts/liquor/application.js'.freeze, 'app/assets/stylesheets/liquor'.freeze, 'app/assets/stylesheets/liquor/application.css'.freeze, 'app/controllers/liquor'.freeze, 'app/controllers/liquor/application_controller.rb'.freeze, 'app/controllers/liquor/completions_controller.rb'.freeze, 'app/controllers/liquor/sandbox_controller.rb'.freeze, 'app/helpers/liquor'.freeze, 'app/helpers/liquor/application_helper.rb'.freeze, 'app/jobs/liquor'.freeze, 'app/jobs/liquor/application_job.rb'.freeze, 'app/mailers'.freeze, 'app/mailers/liquor'.freeze, 'app/mailers/liquor/application_mailer.rb'.freeze, 'app/models/concerns'.freeze, 'app/models/concerns/liquor'.freeze, 'app/models/concerns/liquor/to_liquid.rb'.freeze, 'app/models/liquor'.freeze, 'app/models/liquor/application_record.rb'.freeze, 'app/views/liquor'.freeze, 'app/views/liquor/sandbox'.freeze, 'app/views/liquor/sandbox/index.html.slim'.freeze, 'config/routes.rb'.freeze, 'lib/liquor'.freeze, 'lib/liquor.rb'.freeze, 'lib/liquor/configuration.rb'.freeze, 'lib/liquor/drop.rb'.freeze, 'lib/liquor/engine.rb'.freeze, 'lib/liquor/liquid'.freeze, 'lib/liquor/liquid/drops'.freeze, 'lib/liquor/liquid/drops/active_storage_attached_many_drop.rb'.freeze, 'lib/liquor/liquid/drops/active_storage_attached_one_drop.rb'.freeze, 'lib/liquor/liquid/drops/active_storage_attachment_drop.rb'.freeze, 'lib/liquor/liquid/drops/enumerator_lazy_drop.rb'.freeze, 'lib/liquor/liquid/filters'.freeze, 'lib/liquor/liquid/filters/encode_filter.rb'.freeze, 'lib/liquor/liquid/filters/format_filter.rb'.freeze, 'lib/liquor/liquid/filters/localize_filter.rb'.freeze, 'lib/liquor/liquid/filters/strptime_filter.rb'.freeze, 'lib/liquor/liquid/filters/array_wrap_filter.rb'.freeze, 'lib/liquor/liquid/filters/sum_filter.rb'.freeze, 'lib/liquor/liquid/filters/timezone_filter.rb'.freeze, 'lib/liquor/liquid/filters/to_filter.rb'.freeze, 'lib/liquor/liquid/filters/translate_filter.rb'.freeze, 'lib/liquor/liquid/filters/where_exp_filter.rb'.freeze, 'lib/liquor/liquid/liquid_helpers.rb'.freeze, 'lib/liquor/liquid/liquid_template_extensions.rb'.freeze, 'lib/liquor/liquid/liquor_block.rb'.freeze, 'lib/liquor/liquid/liquor_tag.rb'.freeze, 'lib/liquor/liquid/parser.rb'.freeze, 'lib/liquor/liquid/tags'.freeze, 'lib/liquor/liquid/tags/helper_tag.rb'.freeze, 'lib/liquor/liquid/tags/render_tag.rb'.freeze, 'lib/liquor/version.rb'.freeze]
  s.homepage = 'https://github.com/entdec/liquor'.freeze
  s.licenses = ['MIT'.freeze]
  s.rubygems_version = '3.1.6'.freeze
  s.summary = 'Liquid templating - on steroids'.freeze

  s.installed_by_version = '3.1.6' if s.respond_to? :installed_by_version

  s.specification_version = 4 if s.respond_to? :specification_version

  if s.respond_to? :add_runtime_dependency
    s.add_runtime_dependency('babel-transpiler'.freeze, ['~> 0.7'])
    s.add_runtime_dependency('addressable'.freeze, ['~> 2'])
    s.add_runtime_dependency('i18n'.freeze, ['~> 1.8'])
    s.add_runtime_dependency('kramdown'.freeze, ['~> 2.1'])
    s.add_runtime_dependency('kramdown-parser-gfm'.freeze, ['~> 1.0'])
    s.add_runtime_dependency('liquid'.freeze, ['~> 5.0'])
    s.add_runtime_dependency('parslet'.freeze, ['>= 0'])
    s.add_runtime_dependency('pg'.freeze, ['>= 0'])
    s.add_runtime_dependency('rails'.freeze, ['>= 5.2'])
    s.add_runtime_dependency('sassc'.freeze, ['~> 2.2'])
    s.add_runtime_dependency('slim-rails'.freeze, ['~> 3.2.0'])
    s.add_development_dependency('auxilium'.freeze, ['~> 0.2'])
    s.add_development_dependency('minitest'.freeze, ['~> 5.11'])
    s.add_development_dependency('minitest-reporters'.freeze, ['~> 1.1'])
    s.add_development_dependency('pry'.freeze, ['>= 0'])
    s.add_development_dependency('pry-rails'.freeze, ['~> 0.3'])
    s.add_development_dependency('rubocop'.freeze, ['~> 1'])
  else
    s.add_dependency('babel-transpiler'.freeze, ['~> 0.7'])
    s.add_dependency('addressable'.freeze, ['~> 2'])
    s.add_dependency('i18n'.freeze, ['~> 1.8'])
    s.add_dependency('kramdown'.freeze, ['~> 2.1'])
    s.add_dependency('kramdown-parser-gfm'.freeze, ['~> 1.0'])
    s.add_dependency('liquid'.freeze, ['~> 5.0'])
    s.add_dependency('parslet'.freeze, ['>= 0'])
    s.add_dependency('pg'.freeze, ['>= 0'])
    s.add_dependency('rails'.freeze, ['>= 5.2'])
    s.add_dependency('sassc'.freeze, ['~> 2.2'])
    s.add_dependency('slim-rails'.freeze, ['~> 3.2.0'])
    s.add_dependency('auxilium'.freeze, ['~> 0.2'])
    s.add_dependency('minitest'.freeze, ['~> 5.11'])
    s.add_dependency('minitest-reporters'.freeze, ['~> 1.1'])
    s.add_dependency('pry'.freeze, ['>= 0'])
    s.add_dependency('pry-rails'.freeze, ['~> 0.3'])
    s.add_dependency('rubocop'.freeze, ['~> 1'])
  end
end
