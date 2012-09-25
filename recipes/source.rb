# this recipe is used to build Asterisk from source and install it

include_recipe "subversion::client"

# TODO: add attributes to make more things dynamic

subversion "Asterisk #{node['asterisk']['branch']}" do
  repository "http://svn.asterisk.org/svn/asterisk/branches/#{node['asterisk']['branch']}"
  destination node['asterisk']['source_path']
  action :sync
  notifies :run, "execute[configure script]", :immediately
  notifies :run, "execute[build asterisk]", :immediately
  notifies :run, "execute[install asterisk]", :immediately
end

execute "configure script" do
  action :nothing
  cwd node['asterisk']['source_path']
  command "./configure"
end

execute "build asterisk" do
  action :nothing
  cwd node['asterisk']['source_path']
  command "make"
end

execute "install asterisk" do
  action :nothing
  cwd node['asterisk']['source_path']
  command "make install"
  user "root"
end

directory "/etc/asterisk" do
  action :create
  owner "root"
  group "root"
end

remote_file "/etc/asterisk/indications.conf" do
  action :create_if_missing
  source "http://svn.asterisk.org/svn/asterisk/branches/11/configs/indications.conf.sample"
  mode 00644
end

# make this a local template since we'll want to switch this to using node.asterisk.systemuser
remote_file "/etc/asterisk/asterisk.conf" do
  action :create_if_missing
  source "http://svn.asterisk.org/svn/asterisk/branches/11/configs/asterisk.conf.sample"
  mode 00644
end
