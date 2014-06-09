log 'Ensuring central directories...'

node[:central].each do |name, path|
  directory path do 
    owner node[:whoami][:user]
    group node[:whoami][:group]
    mode '0755'
    recursive true
  end
end
