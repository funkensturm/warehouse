log "Ensuring user #{node[:whoami][:user]}..."
access_user node[:whoami][:user] do
  group node[:whoami][:group]
  home node[:whoami][:home]
end

log "Giving user #{node[:whoami][:user]} passwordless sudo rights..."
ruby_block 'power-for-chef' do
  block do
    file = Chef::Util::FileEdit.new('/etc/sudoers')
    file.insert_line_if_no_match %r{#{node[:whoami][:user]}}, "#{node[:whoami][:user]} ALL=(ALL) NOPASSWD: ALL"
    file.write_file
  end
end

log "Storing node identifier #{node[:whoami][:identifier]} on filesystem..."
file '/etc/me' do
  mode '0755'
  content node[:whoami][:identifier]
end
