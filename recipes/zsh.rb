# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: zsh
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

# the ~/.oh-my-zsh directory path
omzsh = ::File.join(home, ".oh-my-zsh")

## Install oh-my-zsh
#
git omzsh do
  group grp
  repository "git@github.com:robbyrussell/oh-my-zsh.git"
  user id
  action :sync
end

## Render ~/.zshrc
#
template ::File.join(home, ".zshrc") do
  group grp
  owner id
  source "home/dotzshrc.zsh.erb"
  variables(:plugins => %w{ gpg-agent })
  action :create
end
