action :configure do

  ssh_path = ::File.join(new_resource.home, '.ssh')

  log "Ensuring SSH directory for user #{new_resource.owner}..."
  directory ssh_path do
    owner new_resource.owner
    group new_resource.group
    mode '0755'
    recursive true
  end

  log "Ensuring SSH config file for user #{new_resource.owner}..."
  template ::File.join(ssh_path, 'config') do
    cookbook 'access'
    owner new_resource.owner
    group new_resource.group
    mode '0644'
    source 'ssh/config.erb'
  end

  log "Adding SSH public keys for user #{new_resource.owner}..."

  keys = {}
  node[:access][:ssh].each do |keyname, key|
    keys[keyname] = key
  end

  template ::File.join(ssh_path, 'authorized_keys')do
    cookbook 'access'
    owner new_resource.owner
    group new_resource.group
    mode '0600'
    source 'ssh/authorized_keys.erb'
    variables({
      keys: keys
    })
  end

  log "Adding private github key for user #{new_resource.owner}..."
  file "#{ssh_path}/github" do
    owner new_resource.owner
    group new_resource.group
    mode '0600'
    content node[:access][:github][:private_ssh_key]
  end

end
