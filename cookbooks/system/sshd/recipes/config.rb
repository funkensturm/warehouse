log 'Configuring sshd...'

template '/etc/ssh/sshd_config' do
  owner 'root'
  group 'root'
  mode '600'
  source 'sshd_config.erb'
  variables({
    port: node[:sshd][:port],
  })
  notifies :restart, 'service[ssh]'
end

service 'ssh' do
  if node['platform'] == 'ubuntu' && node['platform_version'].to_f < 15.04
    provider Chef::Provider::Service::Upstart
  end
  action [:enable, :start]
  supports [:status, :start, :stop, :restart, :reload]
end
