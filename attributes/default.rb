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

  # vagrant stuff
  ns["vagrant"] = {
    "sha" =>
      "e2c7af6d032ac551ebd6399265cb9cb64402c9fb96a12289161b7f67afada28a",
    "uri" =>
      "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5_x86_64.deb"
  }
end
