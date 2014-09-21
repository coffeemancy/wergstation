# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: xfce
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

# ~/.fonts dir
dotfonts = ::File.join(home, ".fonts")

# config files for xfce4
cfgs = %w{ helpers.rc
           terminal/terminalrc }.
  map { |cfg| ".config/xfce4/#{cfg}" }

## Create directory structure for xfce4 config files
#
cfgs.map { |cfg| cfg.rpartition("/").first }.
  each do |dir|
    directory ::File.join(home, dir) do
      group grp
      mode "0750"
      owner "id"
      action :create
    end
  end

## Render xfce4 config files
#
cfgs.each do |cfg|
  template ::File.join(home, cfg) do
    group grp
    mode "0640"
    owner id
    source "home/#{cfg.sub(/^\./, "dot")}.erb"
    variables(:font => "Source Code Pro Medium 12")
    action :create
  end
end

## Install unzip
#
package "unzip" do
  action :install
end

## Create ~/.fonts
#
directory dotfonts do
  group grp
  mode "0750"
  owner id
  action :create
end

## Download fonts
#
font = "SourceCodePro_FontsOnly-1.017"
zip_dir = ::File.join(Chef::Config[:file_cache_path], font)
zip = "#{zip_dir}.zip"

execute "fc-cache -f -v" do
  cwd home
  group grp
  user id
  action :nothing
end

# FIXME: 2 -- HACK with chown
execute "copy #{font} OTFs" do
  command "cp -v #{::File.join(zip_dir, "OTF")}/* #{dotfonts} "\
          "&& chown #{id}:#{grp} #{dotfonts}/*"
  cwd zip_dir
  action :nothing
  notifies :run, "execute[fc-cache -f -v]", :immediately
end

remote_file zip do
  group grp
  mode "0640"
  owner id
  source "http://sourceforge.net/projects/sourcecodepro.adobe/files/#{font}.zip"
  action :create_if_missing
end

execute "unzip #{zip}" do
  creates zip_dir
  cwd Chef::Config[:file_cache_path]
  action :run
  notifies :run, "execute[copy #{font} OTFs]", :immediately
end
