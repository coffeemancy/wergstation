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
