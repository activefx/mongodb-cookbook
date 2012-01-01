apt_repository "10gen" do
  uri "http://downloads-distro.mongodb.org/repo/ubuntu-upstart"
  keyserver "keyserver.ubuntu.com"
  key "7F0CEB10"
  distribution "dist"
  components %w[10gen]
  action :add
end

package "mongodb-10gen" do
  version "#{node[:mongodb][:server][:version]}*"
end

service "mongodb" do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :stop => true, :restart => true
  action [:enable, :start]
end

directory node[:mongodb][:server][:dbpath] do
  owner "mongodb"
  group "mongodb"
  mode "0775"
  recursive true
end

directory node[:mongodb][:server][:logpath] do
  owner "mongodb"
  group "mongodb"
  mode "0775"
  recursive true
end

template "/etc/init/mongodb.conf" do
  source "mongodb.upstart.erb"
  owner "root"
  group "root"
  mode "0644"
  backup false
  notifies :restart, resources(:service => "mongodb")
end

template node[:mongodb][:server][:config] do
  owner "root"
  group "root"
  mode "0644"
  backup false
  notifies :restart, resources(:service => "mongodb")
end

