password = node['mysql']['password']

log "Installing debconf utils..."
parcel 'debconf-utils'

log 'Ensuring preseed directory...'
directory "/var/cache/local/preseeding" do
  owner "root"
  group "root"
  mode 0755
  recursive true
end

# defines the command preseed mysql-server that gets triggered by notifies :run (see below)
execute "preseed mysql-server" do
  command "debconf-set-selections /var/cache/local/preseeding/mysql-server.seed"
  action :nothing
end

log "Presseding MySQL password"
template "/var/cache/local/preseeding/mysql-server.seed" do
  source "mysql-server.seed.erb"
  owner "root"
  group "root"
  mode "0600"
  variables({
    password: password,
  })
  notifies :run, resources(execute: "preseed mysql-server"), :immediately
end