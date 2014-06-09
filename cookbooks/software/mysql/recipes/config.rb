username    = node[:mysql][:user]
config_path = node[:mysql][:config_path]

log 'Ensuring MySQL config directory...'
directory config_path.to_s do
  owner username
  group username
  mode '0755'
end

log 'Configuring MySQL...'
template config_path.join('my.cnf').to_s do
  source "my.cnf.erb"
  owner username
  group username
  mode "0644"
  notifies :restart, 'service[mysql]', :immediately
end