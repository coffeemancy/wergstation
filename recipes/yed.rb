# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: yed
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

optyed = "/opt/yed"

## Download yed deb
#
zip = ::File.join(Chef::Config[:file_cache_path],
                  ns["yed"]["uri"].rpartition("/").last)

remote_file zip do
  backup false
  source ns["yed"]["uri"]
  action :create_if_missing
end

## Create /opt/yed
#
directory optyed do
  group "root"
  mode "0755"
  owner "root"
  action :create
  notifies :run, "execute[unzip #{zip}]", :immediately
end

## Unzip yed when notified to
#
execute "unzip #{zip}" do
  cwd optyed
  action :nothing
end

## Render ~/bin/yed
#
vers = ns["yed"]["uri"].rpartition("/").last.gsub(/\.zip/, "").downcase

template ::File.join(home, "bin", "yed") do
  group grp
  mode "0700"
  owner id
  variables(:path => ::File.join(optyed, vers, "yed.jar"))
  source "home/bin/yed.erb"
  action :create
end
