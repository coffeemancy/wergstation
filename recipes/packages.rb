# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: packages
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# # initial apt-get update, if add-apt-repository is not installed
# execute "apt-get update" do
#   action :run
#   only_if do
#     which = Mixlib::ShellOut.new("which add-apt-repository").run_command
#     /add-apt-repository/.match(which).empty?
#   end
#   notifies :install, "package[python-software-properties]", :immediately
# end
#
# package "python-software-properties" do
#   action :nothing
# end

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
ns["repos"].each do |action, ppas|
  ppa_action = action.to_sym
  ppas.each do |ppa, opts|
    apt_repository ppa do
      action ppa_action
      components opts["components"] if opts.fetch("components", false)
      key opts["key"]
      uri opts["uri"]
      notifies :run, "ruby_block[apt-needs-update]", :immediately
    end
  end
end

## Update apt
#
# Only runs if a PPA was installed or removed.
#
ruby_block "apt-get maybe update" do
  block do
    if node["wergstation"].fetch("update-apt", false)
      r = Chef::Resource::Execute.new("apt-get update", run_context)
      r.run_action :run
    end
  end
  action :run
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
