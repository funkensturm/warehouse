name             = node[:memcached][:user]
config           = "-m #{node[:memcached][:memory]} -p #{node[:memcached][:port]} -u #{node[:memcached][:user]} -l #{node[:memcached][:listen]}"
log_path         = Pathname.new node[:central][:log] + '/memcached'
logfile          = ::File.join log_path, 'upstart.log'


log 'Installing Memcached upstart job...'
upstart 'memcached' do
  user name
  logfile logfile
  command "/usr/bin/memcached #{config}"
end

log 'Ensuring Memcached upstart job is running...'
service "memcached" do
  provider Chef::Provider::Service::Upstart
  action [ :enable, :start ]
end
