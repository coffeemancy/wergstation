# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: tmux
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

## Install tmux
#
package "tmux" do
  action :install
end

## Render tmux.conf
#
template ::File.join(home, ".tmux.conf") do
  group grp
  mode "0640"
  owner id
  source "home/dottmux.conf.erb"
  action :create
end
