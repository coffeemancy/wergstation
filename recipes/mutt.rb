# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: mutt
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

dotmutt = ::File.join(home, ".mutt")
maildir = ::File.join(home, "mail")

## Install mutt
#
package "mutt" do
  action :install
end

## Set up ~/mail directories
#
%w{ inbox sent postponed }.
  map { |d| ::File.join(maildir, d) }.
  unshift(maildir).
  unshift(dotmutt).
  each do |dir|
    directory dir do
      group grp
      mode "0750"
      owner id
      action :create
    end
  end

## Render ~/.muttrc
#
template ::File.join(home, ".muttrc") do
  group grp
  mode "0640"
  owner id
  variables(:settings => ns["mutt"])
  source "home/dotmuttrc.erb"
  action :create
end
