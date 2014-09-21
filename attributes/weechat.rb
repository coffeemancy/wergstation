# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: weechat
#
# Copyfree (F) 2014 Carlton Stedman
#

include_attribute "wergstation::default"

id = node["wergstation"]["user"]["id"]

# weechat settings for ~/.weechat/*.conf files
default["wergstation"]["weechat"] = {
  "username" => id,
  "nicks" => (1..4).map { |x| "#{id}#{x}" }.unshift(id)
}
