source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in liquidum.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

source "https://rubygems.pkg.github.com/entdec" do
  gem "shipkit"
end

# The sandbox and conversion pages use Satis, as host apps do (and Satis's
# tailwindcss-rails an asset pipeline)
gem "satis"
gem "propshaft"
# The sandboxes table is a Mensa table
git_source(:entdec) { |repo_name| "git@github.com:entdec/#{repo_name}.git" }
gem "mensa", entdec: "mensa"
