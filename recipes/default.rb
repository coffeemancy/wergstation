# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: default
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

%w{ packages
    bashrc
    emacs
    rbenv
    clojure
    tmux
    ssh
    vagrant
    packer
    weechat
    xfce
    xmonad }.
  each do |recipe|
    include_recipe "wergstation::#{recipe}"
  end

## Use zsh
#
execute "chsh -s /usr/bin/zsh #{id}" do
  action :run
end
