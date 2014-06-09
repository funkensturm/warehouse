# apt-get installed a upstart script. we just register the service
log 'Ensuring MySQL upstart job is running...'
service "mysql" do
  provider Chef::Provider::Service::Upstart
  action :nothing
end
