name = node[:gitserver][:user]
home_path = File.join('/mnt/repositories')

log "Ensuring user #{name}..."
access_user name do
  group name
  home home_path
end
