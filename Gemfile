# encoding: UTF-8
source "http://rubygems.org"

gem "hashie", "~> 2.1"
gem "chef", "= 11.12.8"
gem "json", "~> 1.7.7"
gem "berkshelf", "= 2.0.18"
gem "faraday", "< 0.9.0"
gem "thor-scmversion", "= 1.4.0"
gem "colorize", ">= 0.5.8"

# testing
group :test do
  # rake testing
  gem "chefspec", "~> 4.0"
  gem "chef-sugar", "~> 2.0"
  gem "foodcritic", "~> 4.0"
  gem "rubocop", "~> 0.25"

  # test-kitchen testing
  gem "chef-zero", "~> 2.0"
  gem "test-kitchen", "~> 1.2"
  gem "kitchen-vagrant", "~> 0.15"
  gem "serverspec", "~> 2.0.0.beta20"

  # guard stuff
  gem "guard", "~> 2.6"
  gem "guard-rake", "~> 0.0.9"
end

# development and debugging (not installed by CI/jenkins)
group :development do
  gem "pry", "~> 0.10"
  gem "pry-coolline", "~> 0.2"
  gem "pry-debugger", "~> 0.2"
  gem "pry-rescue", "~> 1.4"
  gem "pry-stack_explorer", "~> 0.4"
end
