# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: emacs
#
# Copyfree (F) 2014 Carlton Stedman
#

default["wergstation"]["emacs"].tap do |emacs|
  emacs["package-archives"] = {
    "gnu"       => "http://elpa.gnu.org/packages/",
    "marmalade" => "http://marmalade-repo.org/packages/",
    "melpa"     => "http://melpa.milkbox.net/packages/",
    "tromey"    => "http://tromey.com/elpa/" }
end
