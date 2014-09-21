# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: ruby
#
# Copyfree (F) 2014 Carlton Stedman
#

# settings for ruby
default["wergstation"]["ruby"] = {
  # rbenv
  "rbenv" => {
    "repo" => "https://github.com/sstephenson/rbenv.git"
  },
  # ruby-build
  "ruby-build" => {
    "repo" => "https://github.com/sstephenson/ruby-build.git"
  },
  # versions to install for rbenv
  "versions" => %w{ 1.9.3-p484 },
  # global version to use with rbenv
  "global" => "1.9.3-p484",
  # gems to install with rbenv exec
  "gems" => %w{ bundler
                pry
                pry-coolline
                pry-debugger
                pry-rescue
                pry-stack_explorer }
}
