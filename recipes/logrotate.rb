include_recipe "logrotate"

logrotate_app "mongodb" do
  path node[:mongodb][:server][:logpath]
  frequency node[:mongodb][:logrotate][:period]
  rotate node[:mongodb][:logrotate][:keep]
  compress true
  # http://www.mongodb.org/display/DOCS/Logging
  restart_command "kill -SIGUSR1 `cat #{node[:mongodb][:server][:pidfile]}`"
end

