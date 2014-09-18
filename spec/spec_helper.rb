# encoding: UTF-8
require "chefspec"
require "chefspec/berkshelf"
require "chefspec/cacher"
require "chef/sugar"

RSpec.configure do |config|
  config.log_level = (ENV["RSPEC_LOG_LEVEL"] || :warn).to_sym
  config.platform = "ubuntu"
  config.version = "14.04"
end
