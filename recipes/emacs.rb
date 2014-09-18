# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: emacs
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

emacs_d = ::File.join(home, ".emacs.d")

## Install emacs
#
package "emacs24" do
  action :install
end

## Create emacs.d
#
directory emacs_d do
  group grp
  mode "0750"
  owner id
  action :create
end

## Render emacs init.el
#
template ::File(emacs_d, "init.el") do
  group grp
  mode "0640"
  owner id
  source "home/dotemacs.d/init.el.erb"
  variables(:packages => ns["emacs"]["package-archives"])
  action :create
end
