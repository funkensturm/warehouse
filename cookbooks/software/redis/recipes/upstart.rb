name = 'redis'

config_path      = node[:redis][:config_path]
config_file_path = ::File.join config_path, 'redis.conf'
log_path         = ::File.join node[:central][:log], 'redis'
log_file_path    = ::File.join log_path, 'upstart.log'

log 'Installing Redis upstart job...'
upstart 'redis' do
  user name
  logfile log_file_path
  command "redis-server #{config_file_path}"
end

log 'Ensuring Redis upstart job is running...'
service "redis" do
  provider Chef::Provider::Service::Upstart
  action [ :enable, :start ]
end
