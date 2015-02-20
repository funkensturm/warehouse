# apt-get installed a upstart script. we just register the service
log 'Ensuring PostgreSQL upstart job is running...'
service "postgres" do
  provider Chef::Provider::Service::Upstart
  action :nothing
end
