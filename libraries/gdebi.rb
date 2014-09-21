# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Library:: gdebi
#
# Copyfree (F) Carlton Stedman
#

require "chef/resource/package"
require "chef/provider/package/dpkg"

class Chef
  class Provider
    class Package
      # Create a gdebi_package provider based on dpkg_package
      class Gdebi < Chef::Provider::Package::Dpkg
        def install_package(_name, _version)
          options, source = @new_resource.options, @new_resource.source
          opts = options ? " --option='#{options}'" : ""

          args = {
            :command     => "gdebi --quiet --non-interactive#{opts} #{source}",
            :environment => { "DEBIAN_FRONTEND" => "noninteractive" } }

          run_command_with_systems_locale(args)
        end
      end
    end
  end

  class Resource
    # Create a gdebi_package resource based on the package resource
    class GdebiPackage < Chef::Resource::Package
      def initialize(name, run_context = nil)
        super
        @resource_name = :gdebi_package
        @provider = Chef::Provider::Package::Gdebi
      end
    end
  end
end
