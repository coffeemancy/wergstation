# encoding: UTF-8
# rubocop:disable SingleSpaceBeforeFirstArg, LineLength
name             "wergstation"
maintainer       "Carlton Stedman"
maintainer_email "sageman@gmail.com"
license          "All rights reserved"
description      "Installs/Configures wergstation"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          IO.read(File.join(File.dirname(__FILE__), "VERSION")) rescue "0.0.1"

## dependencies
depends "apt"

## supports
supports "ubuntu", "= 14.04"
