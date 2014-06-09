action :create do

  log "Ensuring user group #{new_resource.group}..."
  group new_resource.group

  log "Ensuring user #{new_resource.name} with home #{new_resource.home}..."
  user new_resource.name do
    gid new_resource.name
    home new_resource.home
    supports manage_home: true
  end

  log "Ensuring correct permissions on home directory for user #{new_resource.name}..."
  directory new_resource.home do
    owner new_resource.name
    group new_resource.group
    mode '0755'
    recursive true
  end

  log "Ensuring that bash is the shell for user #{new_resource.name}..."
  execute "usermod-bash" do
    command "sudo usermod -s /bin/bash #{new_resource.name}"
  end

  log "Configuring bash for user #{new_resource.name}..."
  access_bash_profile new_resource.home do
    owner new_resource.name
    group new_resource.group
  end

  log "Configuring SSH for user #{new_resource.name}..."
  access_ssh_config new_resource.home do
    owner new_resource.name
    group new_resource.group
  end

end
