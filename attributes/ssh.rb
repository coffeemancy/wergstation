# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: emacs
#
# Copyfree (F) 2014 Carlton Stedman
#

default["wergstation"]["ssh"] = {
  # config file options
  "config" => {
    # host definitions for ~/.ssh/config
    # key: String regex of host name
    # value: Hash -- options written as k/v pairs, except for "misc"
    #                which is array of strings added after k/v pairs
    "hosts" => {
      "github.com" => {
        "user" => "carltonstedman",
        "key"  => "~/.ssh/keys/github_dot_com_rsa",
        "misc" => %w{ IdentitiesOnly=yes } } } }
}
