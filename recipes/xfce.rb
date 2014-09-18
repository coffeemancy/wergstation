# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: default
#
# Copyfree (F) 2014 Carlton Stedman
#

%w{ packages
    bashrc
    emacs
    xmonad }.
  each do |recipe|
    include_recipe "wergstation::recipe"
  end
