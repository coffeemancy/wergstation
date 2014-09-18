# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: bashrc
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

# the ~/.bash directory path
dotbash = ::File.join(home, ".bash")

## Create ~/.bash and dump into it scripts for ~/.bashrc to source
#
remote_directory dotbash do
  files_group grp
  files_mode "0640"
  files_owner id
  group grp
  mode "0750"
  owner id

  # don't delete already existing files
  purge false
  source "home/dotbash"
  action :create
end

## Render aliases template in ~/.bash/aliases.sh
#
template ::File.join(dotbash, "aliases.sh") do
  group grp
  mode "0640"
  owner id
  source "home/dotbash/aliases.sh.erb"
  variables(:aliases => ns["bash"]["aliases"])
  action :create
end

## Render ~/.bashrc
#
template ::File.join(home, ".bashrc") do
  group grp
  mode "0640"
  owner id
  source "home/dotbashrc.sh.erb"
  variables(:exports => ns["bash"]["exports"])
  action :create
end
