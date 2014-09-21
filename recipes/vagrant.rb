# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: vagrant
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

## Install gdebi
#
package "gdebi-core" do
  action :install
end

## Download vagrant deb
#
deb = ns["vagrant"]["uri"].rpartition("/").last
local_path = ::File.join(Chef::Config[:file_cache_path], "#{deb}.deb")

remote_file local_path do
  backup false
  checksum ns["vagrant"]["sha"]
  source ns["vagrant"]["uri"]
  action :create
end

## Install vagrant with gdebi provider
#
gdebi_package deb do
  source local_path
  action :install
end
