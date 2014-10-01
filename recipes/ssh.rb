# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: ssh
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

dotssh  = ::File.join(home, ".ssh")
keysdir = ::File.join(dotssh, "keys")

## Create ~/.ssh, ~/.ssh/keys
#
[dotssh, keysdir].
  each do |dir|
    directory dir do
      group grp
      mode "0700"
      owner id
      action :create
    end
  end

## Render ~/.ssh/config
#
# template ::File.join(dotssh, "config") do
#   group grp
#   mode "0600"
#   owner id
#   source "home/dotssh/config.erb"
#   variables(:settings => ns["ssh"])
#   action :create
# end
