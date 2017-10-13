username    = node[:postgres][:user]
config_path = node[:postgres][:config_path]
log_path    = Pathname.new(node[:central][:log]).join 'postgres'

log 'Ensuring PostgreSQL config directory...'
directory config_path.to_s do
  owner username
  group username
  mode '0755'
end

log 'Configuring PostgreSQL host based auth...'
template config_path.join('pg_hba.conf').to_s do
  source "pg_hba.conf.erb"
  owner username
  group username
  mode "0644"
  notifies :restart, 'service[postgresql]', :immediately
end

log 'Ensuring PostgreSQL log directory...'
directory log_path.to_s do
  owner username
  group username
  mode '0755'
end

if node['platform'] == 'ubuntu' && node['platform_version'].to_f < 15.04
  log_path     = ::File.join node[:central][:log], 'postgres'
  logfile_path = ::File.join log_path, 'upstart.log'
  version      = node[:postgres][:version]

  log 'Installing PostgreSQL upstart job...'
  upstart 'postgresql' do
    user 'postgres'
    logfile logfile_path
    command "/usr/lib/postgresql/#{version}/bin/postgres -D /var/lib/postgresql/#{version}/main -c config_file=/etc/postgresql/#{version}/main/postgresql.conf"
    notifies :restart, 'service[postgresql]'
  end
end

log 'Ensuring PostgreSQL job is running...'
service 'postgresql' do
  if node['platform'] == 'ubuntu' && node['platform_version'].to_f < 15.04
    provider Chef::Provider::Service::Upstart
  end
  action [:enable, :start]
end
