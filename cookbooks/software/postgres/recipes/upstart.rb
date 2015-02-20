name = 'postgres'

log_path     = ::File.join node[:central][:log], name
logfile_path = ::File.join log_path, 'upstart.log'


log 'Installing PostgreSQL upstart job...'
upstart name do
  user 'postgres'
  logfile logfile_path
  command '/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf'
  notifies :restart, 'service[postgres]'
end

log 'Ensuring PostgreSQL upstart job is running...'
service 'postgres' do
  provider Chef::Provider::Service::Upstart
  action [ :enable, :start ]
end
