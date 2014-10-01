# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Recipe:: clojure
#
# Copyfree (F) 2014 Carlton Stedman
#

ns = node["wergstation"]

# user's id, group, home
id, grp, home = %w{ id group home }.map { |k| ns["user"][k] }

mybin   = ::File.join(home, "bin")
dotlein = ::File.join(home, ".lein")

## Create ~/bin
#
directory mybin do
  group grp
  mode "0750"
  owner id
  action :create
end

## Install leinengen
#
remote_file ::File.join(mybin, "lein") do
  group grp
  mode "0750"
  owner id
  source "https://raw.githubusercontent.com/technomancy/leiningen" \
         "/stable/bin/lein"
  action :create_if_missing
end

## Create ~/.lein
#
directory dotlein do
  group grp
  mode "0750"
  owner id
  action :create
end

## Render ~/.lein/profiles.clj
#
template ::File.join(dotlein, "profiles.clj") do
  group grp
  mode "0640"
  owner id
  source "home/dotlein/profiles.clj.erb"
  variables(:settings => ns["clojure"]["lein"])
  action :create
end

## Install lein deps
#
execute "#{::File.join(mybin, "lein")} deps" do
  cwd home
  group grp
  # don't worry about "error" from no project.clj
  returns [0, 1]
  user id
  action :run
end
