name = 'murmur'

log_path     = ::File.join node[:central][:log], name
logfile_path = ::File.join log_path, 'upstart.log'

log 'Installing Murmur upstart job...'
upstart name do
  user 'mumble-server'
  logfile logfile_path
  command '/usr/sbin/murmurd -fg -ini /etc/mumble-server.ini'
  notifies :restart, 'service[murmur]'
end

log 'Ensuring Murmur upstart job is running...'
service 'murmur' do
  provider Chef::Provider::Service::Upstart
  action [ :enable, :start ]
end
