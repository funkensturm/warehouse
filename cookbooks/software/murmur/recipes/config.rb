name          = 'murmur'
log_path      = ::File.join(node[:central][:log], name)
logfile_path  = ::File.join(log_path, "#{name}.log")
ssl_cert_path = ::File.join('/etc/ssl/certs', "#{name}.crt")
ssl_key_path  = ::File.join('/etc/ssl', "#{name}.key")

log 'Ensuring Murmur log directory...'
directory log_path do
  owner 'root'
  group 'mumble-server'
  mode '0755'
end

log 'Configuring Murmur...'
template '/etc/mumble-server.ini' do
  source "mumble-server.ini.erb"
  variables({
    logfile_path: logfile_path,
    password: node[name][:password],
    ssl_cert_path: ssl_cert_path,
    ssl_key_path: ssl_key_path,
  })
  owner 'root'
  group 'mumble-server'
  mode '0644'
end

if node[name][:ssl_cert].to_s != ''

  log "Installing SSL certificate for #{name}..."

  file ssl_cert_path do
    owner 'root'
    group 'mumble-server'
    content node[name][:ssl_cert]
    mode '0644'
  end

  file ssl_key_path do
    owner 'root'
    group 'mumble-server'
    content node[name][:ssl_key]
    mode '0640'
  end

end
