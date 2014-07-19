name          = 'memcached'
config_path   = Pathname.new '/etc'
log_path      = Pathname.new node[:central][:log] + '/memcached'
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


log 'Configuring Memcached...'
template config_path.join('memcached.conf').to_s do
  source "memcached.conf.erb"
  owner name
  group name
  mode '0644'
  variables({
    :listen => node['memcached']['listen'],
    :user => node['memcached']['user'],
    :port => node['memcached']['port'],
    :maxconn => node['memcached']['maxconn'],
    :memory => node['memcached']['memory'],
    :logfile => logfile,
    
  })
  notifies :restart, 'service[memcached]'
end