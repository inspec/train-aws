source "https://rubygems.org"

gemspec

gem "train-core", git: "https://github.com/inspec/train.git", branch: "bs/fix-CHEF-8031"
if Gem.ruby_version.to_s.start_with?("2.5")
  # 16.7.23 required ruby 2.6+
  gem "chef-utils", "< 16.7.23" # TODO: remove when we drop ruby 2.5
end

group :development do
  gem "pry"
  gem "bundler"
  gem "byebug"
  gem "minitest"
  gem "mocha"
  gem "m"
  gem "rake"
  gem "chefstyle"
end
