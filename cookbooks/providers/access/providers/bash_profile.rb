action :configure do

  profile_path = "#{new_resource.home}/.bash_profile"
  logout_path  = "#{new_resource.home}/.bash_logout"

  log "Creating #{::File.basename(profile_path)} for user #{new_resource.owner}..."
  template profile_path do
    cookbook 'access'
    owner new_resource.owner
    group new_resource.group
    variables({ user: new_resource.owner })
    source 'bash_profile.erb'
  end

  log "Creating .bash_logout for user #{new_resource.owner}..."
  template logout_path do
    cookbook 'access'
    owner new_resource.owner
    group new_resource.group
    source 'bash_logout.erb'
  end

  log "Removing Amazon SSH welcome messages..."

  execute "usermod-bash" do
    command "rm -rf /etc/update-motd.d/*"
  end

  cache_dir = ::File.join(new_resource.home, '.cache')
  directory cache_dir do
    owner new_resource.owner
    group new_resource.group
  end

  file ::File.join(cache_dir, 'motd.legal-displayed') do
    owner new_resource.owner
    group new_resource.group
    action :touch
  end

  log 'Configuring global SSH welcome message...'

  motd_path = '/etc/motd'
  file motd_path do
    action :delete
  end

  template motd_path do
    cookbook 'access'
    source "sshd/welcome.erb"
  end

end
