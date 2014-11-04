# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: xmonad
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

dotxmonad = ::File.join(home, ".xmonad")

## Install xmonad and third party tiling algorithms
#
%w{ xmonad
    libghc-xmonad-contrib-dev }.
  each do |pkg|
    package pkg do
      action :install
    end
  end

## Make sure .xmonad dir exists
#
directory dotxmonad do
  group grp
  mode "0750"
  owner id
  action :create
end

## Render xmonad.hs file
#
template ::File.join(dotxmonad, "xmonad.hs") do
  group grp
  mode "0640"
  owner id
  source "home/dotxmonad/dotxmonad.hs.erb"
  action :create
end

## Render ~/.xsession file
#
template ::File.join(home, ".xsession") do
  group grp
  mode "0640"
  owner id
  source "home/dotxsession.erb"
  action :create
end
