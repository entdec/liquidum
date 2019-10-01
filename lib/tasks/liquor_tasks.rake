# frozen_string_literal: true

desc 'Release a new version'
task :release do
  version_file = './lib/liquor/version.rb'
  File.open(version_file, 'w') do |file|
    file.puts <<~EOVERSION
      # frozen_string_literal: true

      module Liquor
        VERSION = '#{Liquor::VERSION.split('.').map(&:to_i).tap { |parts| parts[2] += 1 }.join('.')}'
      end
    EOVERSION
  end
  module Liquor
    remove_const :VERSION
  end
  load version_file
  puts "Updated version to #{Liquor::VERSION}"

  `git commit lib/liquor/version.rb -m "Version #{Liquor::VERSION}"`
  `git push`
  `git tag #{Liquor::VERSION}`
  `git push --tags`
end
