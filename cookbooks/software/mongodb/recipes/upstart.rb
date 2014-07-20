name          = 'mongodb'
config_path   = Pathname.new '/etc'
config_file   = ::File.join config_path, 'mongodb.conf'
log_path      = Pathname.new node[:central][:log] + '/mongodb'
logfile       = ::File.join log_path, 'upstart.log'

log 'Installing Mongodb upstart job...'
upstart 'mongodb' do
  user name
  logfile logfile
  command "mongod -f #{config_file}"
end

log 'Ensuring MongoDB upstart job is running...'
service "mongodb" do
  provider Chef::Provider::Service::Upstart
  action [ :enable, :start ]
end
