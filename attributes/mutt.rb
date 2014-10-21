# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: mutt
#
# Copyfree (F) 2014 Carlton Stedman
#

include_attribute "wergstation::default"

id = node["wergstation"]["user"]["id"]

# mutt settings for ~/.muttrc
default["wergstation"]["mutt"] = {
  "from"     => "#{id}@localhost",
  "realname" => id
}
