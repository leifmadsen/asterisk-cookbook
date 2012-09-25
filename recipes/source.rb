# this recipe is used to build Asterisk from source and install it

include_recipe "subversion::client"

# TODO: add attributes to make this dynamic
subversion "Asterisk 11" do
  repository "http://svn.asterisk.org/svn/asterisk/branches/11"
  destination "/opt/mysources/asterisk"
  action :sync
  notifies :run, "execute[configure script]", :immediately
end

execute "configure script" do
  action :nothing
  cwd "/opt/mysources/asterisk"
  command "./configure"
end
