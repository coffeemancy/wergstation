# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: packages
#
# Copyfree (F) 2014 Carlton Stedman
#

default["wergstation"].tap do |ns|
  # PPAs to install
  ns["repos"] = {
    "docker" => {
      "components" => %w{ docker ubuntu },
      "key"        => "36A1D7869245C8950F966E92D8576A8BA88D21E9",
      "uri"        => "https://get.docker.io/ubuntu" },
    "ehoover-compholio" => {
      "components" => %w{ trusty main },
      "key"        => "99ED08A0FCA332C7BD045B6A497A0F381F691896",
      "uri"        => "http://ppa.launchpad.net/ehoover/compholio/ubuntu" },
    "fkrull-deadsnakes" => {
      "components" => %w{ trusty main },
      "key"        => "FF3997E83CD969B409FB24BC5BB92C09DB82666C",
      "uri"        => "http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu" },
    "google" => {
      "components" => %w{ },
      "key"        => "",
      "uri"        => "" },
    "google-talkplugin" => {
      "components" => %w{ },
      "key"        => "",
      "uri"        => "" },
    "oracle-virtualbox" => {
      "components" => %w{ },
      "key"        => "",
      "uri"        => "" },
    "spotify" => {
      "components" => %w{ stable non-free },
      "key"        => "94558F59",
      "uri"        => "http://repository.spotify.com" },
    "webupd8team-java" => {
      "components" => %w{ },
      "key"        => "",
      "uri"        => "" } }

  ## Hash of packages
  #
  # The first-level key is the `action` to perform (e.g. "install", "remove"),
  # which is symbolized in the packages.rb recipe and performed on each package
  # listed in the Array associated with the action.
  #
  ns["packages"] = {
    # base packages to install
    "install" => %w{
      dos2unix
      flashplugin-installer
      gimp
      git
      gnupg2
      google-chrome-stable
      google-talkplugin
      gparted
      htop
      links
      meld
      netflix-desktop
      nmap
      openvpn
      oracle-java7-installer
      pandoc
      pass
      python3
      rdesktop
      spotify-client
      spotify-client-gnome-support
      tmux
      transmission-common
      transmission-gtk
      tree
      vagrant
      virtualbox-4.3
      weechat
      xfce4-goodies },
    # packages to remove
    "remove" => %w{
      abiword
      firefox
      gnumeric
      nano
      pidgin } }
end
