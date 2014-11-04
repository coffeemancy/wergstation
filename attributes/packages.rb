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
    "codealpha" => {
      "components" => %w{ jaunty main },
      "key"        => "90A7FC55",
      "uri"        => "http://ppa.launchpad.net/codealpha/ppa/ubuntu" },
    "cran" => {
      "components" => %w{ trusty/ },
      "key"        => "E084DAB9",
      "uri"        => "http://cran.r-project.org/bin/linux/ubuntu" },
    "docker" => {
      "components" => %w{ docker main },
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
    "google-chrome" => {
      "components" => %w{ stable main },
      "key_uri"    => "https://dl-ssl.google.com/linux/linux_signing_key.pub",
      "uri"        => "http://dl.google.com/linux/chrome/deb/" },
    "google-talkplugin" => {
      "components" => %w{ stable main },
      "key_uri"    => "https://dl-ssl.google.com/linux/linux_signing_key.pub",
      "uri"        => "http://dl.google.com/linux/talkplugin/deb/" },
    "oracle-virtualbox" => {
      "components" => %w{ trusty contrib },
      "key_uri"    => "https://www.virtualbox.org/download/oracle_vbox.asc",
      "uri"        => "http://download.virtualbox.org/virtualbox/debian" },
    "spotify" => {
      "components" => %w{ stable non-free },
      "key"        => "94558F59",
      "uri"        => "http://repository.spotify.com" },
    "webupd8team-java" => {
      "components" => %w{ trusty main },
      "key"        => "EEA14886",
      "uri"        => "http://ppa.launchpad.net/webupd8team/java/ubuntu" } }

  ## Hash of packages
  #
  # The first-level key is the `action` to perform (e.g. "install", "remove"),
  # which is symbolized in the packages.rb recipe and performed on each package
  # listed in the Array associated with the action.
  #
  ns["packages"] = {
    # base packages to install
    "install" => %w{
      dia
      dos2unix
      flashplugin-installer
      gimp
      git
      gnupg2
      google-chrome-stable
      google-talkplugin
      gparted
      gpw
      htop
      inxi
      links
      meld
      midori
      netflix-desktop
      network-manager-openvpn-gnome
      nmap
      openvpn
      oracle-java7-installer
      pandoc
      pass
      python3
      r-base
      r-base-dev
      rdesktop
      spotify-client
      spotify-client-gnome-support
      transmission-common
      transmission-gtk
      tree
      virtualbox-4.3
      dkms
      unzip
      utimer
      xbacklight
      xfce4-goodies
      xtrlock },
    # packages to remove
    "remove" => %w{
      abiword
      firefox
      gnumeric
      nano
      pidgin } }
end
