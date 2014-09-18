# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: xmonad
#
# Copyfree (F) 2014 Carlton Stedman
#

## Install xmonad and third party tiling algorithms
#
%w{ xmonad
    xmonad-contrib }.
  each do |pkg|
    package pkg do
      action :install
    end
  end
