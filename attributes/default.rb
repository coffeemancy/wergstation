# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: default
#
# Copyfree (F) 2014 Carlton Stedman
#

default["wergstation"].tap do |ns|
  # packer stuff
  ns["packer"] = {
    "sha" =>
      "4f7b8cd96a147f9473cc724397613c8d98bbf0d8cb037b122785ff252eb12581",
    "uri" =>
      "https://dl.bintray.com/mitchellh/packer/packer_0.7.1_linux_amd64.zip"
  }

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

  # yed stuff
  ns["yed"] = {
    "uri" =>
      "http://www.yworks.com/products/yed/demo/yEd-3.13.zip"
  }
end
