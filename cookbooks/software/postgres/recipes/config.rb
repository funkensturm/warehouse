username    = node[:postgres][:user]
config_path = node[:postgres][:config_path]

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
  notifies :restart, 'service[postgres]', :immediately
end