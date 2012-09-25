#
# Cookbook Name:: asterisk-cookbook
# Recipe:: default
#
# Copyright 2012, Leif Madsen
#
# All rights reserved
#

include_recipe "build-essential"
include_recipe "ntp"
include_recipe "asterisk::#{node['asterisk']['install_method']}"

case node['platform']
when "centos", "redhat", "rhel", "fedora", "amazon", "scientific"
  include_recipe "yum::epel"
when "debian", "ubuntu"
  include_recipe "apt"
end
