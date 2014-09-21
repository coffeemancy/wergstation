# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: weechat
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

# ~/.weechat dir
dotweechat = ::File.join(home, ".weechat")

## Install weechat
#
package "weechat" do
  action :install
end

## Render weechat configs
#
%w{ irc
    weechat }.
  map { |conf| "#{conf}.conf" }.
  each do |conf|
    template ::File.join(dotweechat, conf) do
      group grp
      mode "0640"
      owner id
      source "home/dotweechat/#{conf}.erb"
      variables(:settings => ns["weechat"])
      action :create
    end
  end
