# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: packer
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

## Download packer zip
#
zip = ::File.join(Chef::Config[:file_cache_path],
                  ns["packer"]["uri"].rpartition("/").last)

remote_file zip do
  backup false
  checksum ns["packer"]["sha"]
  source ns["packer"]["uri"]
  action :create_if_missing
  notifies :run, "execute[unzip #{zip}]", :immediately
end

## Create /opt/packer
#
directory "/opt/packer" do
  group "root"
  mode "0755"
  owner "root"
  action :create
end

## Unzip packer when notified to
#
execute "unzip #{zip}" do
  creates "/opt/packer/packer"
  cwd "/opt/packer"
  action :nothing
end

## Make a symlink in ~/bin
#
link ::File.join(home, "bin", "packer") do
  group grp
  owner id
  to "/opt/packer/packer"
  action :create
end
