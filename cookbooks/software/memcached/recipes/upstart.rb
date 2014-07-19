log 'Ensuring Memcached upstart job is running...'
service "memcached" do
  provider Chef::Provider::Service::Upstart
  action :nothing
end
