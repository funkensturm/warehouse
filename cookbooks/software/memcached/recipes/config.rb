name          = node[:memcached][:user]
config_path   = Pathname.new '/etc'
log_path      = Pathname.new(node[:central][:log]).join 'memcached'
logfile       = ::File.join(log_path, 'memcached.log')

log 'Ensuring Memcached log directory...'
directory log_path.to_s do
  owner name
  group name
  mode '0755'
end

log 'Ensuring persmissions for the Memcached log file...'
file log_path.join('upstart.log').to_s do
  owner name
  group name
  mode '0644'
  action :touch
end