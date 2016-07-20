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
  action :enable
  supports status: true, start: true, stop: true, restart: true, reload: true
end

