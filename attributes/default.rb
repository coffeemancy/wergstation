# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: default
#
# Copyfree (F) 2014 Carlton Stedman
#

default["wergstation"].tap do |ns|
  # user stuff
  ns["user"] = {
    "id"    => "cstedman",
    "group" => "cstedman",
    "home"  => "/home/cstedman"
  }
end
