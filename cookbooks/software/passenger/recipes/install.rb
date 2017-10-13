conf_file_path = node[:passenger][:nginx_path].join('nginx.conf')

log 'Adding Phusion apt repository...'

apt_repository 'passenger' do
  uri          'https://oss-binaries.phusionpassenger.com/apt/passenger'
  distribution node['lsb']['codename']
  components   ['main']
  keyserver    'keyserver.ubuntu.com'
  key          '561F9B9CAC40B2F7'
  deb_src      true
end

log 'Ensuring Passenger...'

parcel 'nginx-extras'
parcel 'passenger'

log 'Configuring nginx...'

template conf_file_path.to_s do
  source 'nginx.conf.erb'
  owner  node[:whoami][:user]
  group  node[:whoami][:group]
  mode   '644'
  variables({
    log_path: ::File.join(node[:central][:log], 'nginx'),
  })
end

log 'Removing nginx init.d script...'

execute 'remote-nginx-initd' do
  command '/usr/sbin/update-rc.d -f nginx remove'
end

file '/etc/init.d/nginx' do
  action :delete
end

log_path      = ::File.join(node[:central][:log], 'nginx')
logfile_path  = ::File.join(log_path, 'upstart.log')

directory log_path do
  owner node[:whoami][:user]
  group node[:whoami][:group]
  mode '0755'
  recursive true
end

log %{Enable logrotation...}
template "/etc/logrotate.d/custom-nginx" do
  owner "root"
  group "root"
  source "logrotate.erb"
  variables({
    log_path: "#{log_path}/*.log"
  })
  mode "644"
end

if node['platform'] == 'ubuntu' && node['platform_version'].to_f < 15.04
  log 'Installing Nginx upstart job...'
  upstart 'nginx' do
    logfile logfile_path
    command %{/usr/sbin/nginx -g "daemon off;"}
  end
end

log 'Ensuring Nginx job is running...'
service 'nginx' do
  if node['platform'] == 'ubuntu' && node['platform_version'].to_f < 15.04
    provider Chef::Provider::Service::Upstart
  end
  action [:enable, :start]
end
