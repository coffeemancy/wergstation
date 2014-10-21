# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: packages
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

include_recipe "apt::default"

node.default["wergstation"]["update-apt"] = false

# resource to notify
ruby_block "apt-needs-update" do
  block do
    node.default["wergstation"]["update-apt"] = true
  end
  action :nothing
end

## Install/remove PPAs
#
# Install/remove each PPA. If any are changed, will trigger an `apt-get update`
# after all the PPA config files are written.
#
ns["repos"].each do |ppa, opts|
  apt_repository ppa do
    components opts["components"] if opts.fetch("components", false)
    key opts.fetch("key", opts["key_uri"])
    keyserver "keyserver.ubuntu.com" if opts.fetch("key", false)
    uri opts["uri"]
    action :add
    notifies :run, "ruby_block[apt-needs-update]", :immediately
  end
end

## Update apt
#
# Only runs if a PPA was installed or removed.
#
ruby_block "apt-get maybe update" do
  block do
    r = Chef::Resource::Execute.new("apt-get update", run_context)
    r.run_action :run
  end
  action :run
  only_if { node["wergstation"].fetch("update-apt", false) }
end

## Accept license agreements
#
["debconf shared/accepted-oracle-license-v1-1"].
  product(%w{ select seen }).
  each do |license, act|
    execute "echo #{license} #{act} true | debconf-set-selections" do
      action :run
    end
  end

## Install/remove/etc packages
#
# Iterate over "packages" Hash, performing action specified for each package,
# e.g. :install, :remove, etc.
#
ns["packages"].each do |action, pkgs|
  pkg_action = action.to_sym
  pkgs.each do |pkg|
    package pkg do
      action pkg_action
    end
  end
end
