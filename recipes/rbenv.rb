# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: rbenv
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

# the ~/.bash and ~/.rbenv directory paths
dotbash  = ::File.join(home, ".bash")
dotrbenv = ::File.join(home, ".rbenv")

## Install rbenv with git
#
git dotrbenv do
  rbenv = ns["ruby"]["rbenv"]
  group grp
  repository rbenv["repo"]
  user id
  action :sync
end

## Write out rbenv file sourced by ~/.bashrc
#
template ::File.join(dotbash, "rbenv.sh") do
  group grp
  mode "0640"
  owner id
  source "home/dotbash/rbenv.sh.erb"
  action :create
end

## Create ~/.rbenv/plugins dir
#
directory ::File.join(dotrbenv, "plugins") do
  group grp
  mode "0750"
  owner id
  action :create
end

## Install ruby-build with git
#
git ::File.join(dotrbenv, "plugins/ruby-build") do
  rbuild = ns["ruby"]["ruby-build"]
  group grp
  repository rbuild["repo"]
  user id
  action :sync
end

node.default["wergstation"]["ruby"]["install-gems?"] = false

ruby_block "install gems" do
  block do
    node.default["wergstation"]["ruby"]["install-gems?"] = true
  end
  action :nothing
end

## Install ruby versions
#
ns["ruby"]["versions"].each do |ruby|
  execute "rbenv install #{ruby}" do
    group grp
    user id
    action :run
    # skip if installed
    not_if do
      Mixlib::ShellOut.new("rbenv versions").
                       run_command.stdout.split("\n").
                       any? { |ln| ln.match(/#{ruby}/) }
    end
    # notify install of gems
    notifies :run, "ruby_block[install gems]", :immediately
  end
end

## Setup default ruby and install gems
#
bash "setup rbenv global and gems" do
  code ["rbenv rehash",
        "rbenv global #{ns["ruby"]["global"]}"].
          concat(ns["ruby"]["gems"].map do |gem|
                   "rbenv exec gem install #{gem}"
                 end).join("\n")
  group grp
  user id
  action :run
  # only do if triggered by install of new ruby version
  only_if { node["wergstation"]["ruby"].fetch("install-gems?", false) }
end
