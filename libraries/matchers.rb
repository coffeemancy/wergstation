# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Library:: matchers
#
# Copyfree (F) Carlton Stedman
#

## Custom ChefSpec Matchers
#
# This file contains customer matchers for chefspec for the L/HWRPs.
#
if defined?(ChefSpec)
  # Chefspec matcher for gdebi_package HWRP
  def install_gdebi_package(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gdebi_package,
                                            :install,
                                            resource_name)
  end
end
