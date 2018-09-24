name = 'redis'
config_path   = node[:redis][:config_path]
data_path     = ::File.join(node[:central][:data], 'redis')
log_path      = ::File.join(node[:central][:log], 'redis')
logfile_path  = ::File.join(log_path, 'redis.log')

log 'Ensuring Redis config directory...'
directory config_path do
  owner name
  group name
  mode '0755'
end

log 'Ensuring Redis database directory...'
directory data_path do
  owner name
  group name
  mode '0755'
end

log 'Ensuring Redis log directory...'
directory log_path do
  owner name
  group name
  mode '0755'
end

log 'Ensuring Redis log file...'
file logfile_path do
  owner name
  group name
  mode '0644'
end

log 'Ensuring overcommit memory on Ubuntu...'
execute "sysctl_overcommit" do
  command '/sbin/sysctl -w vm.overcommit_memory=1'
end

log 'Configuring Raidis...'
file '/etc/redis_master' do
  owner name
  group name
  mode '0644'
  content "127.0.0.1:6379"
end

log 'Systemd service file for redis...'
template ::File.join('lib', 'systemd', 'system', 'redis-server.service') do
  source 'redis-server.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables({
    log_path:  log_path,
    data_path: data_path,
  })
end

log 'Configuring Redis...'
template ::File.join(config_path, 'redis.conf') do
  source 'redis.conf.erb'
  owner name
  group name
  mode '0644'
  variables({
    logfile_path: logfile_path,
    data_path:    data_path,
  })
  notifies :restart, 'service[redis]'
end
