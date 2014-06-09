log 'Ensuring MongoDB upstart job is running...'
service "mongodb" do
  provider Chef::Provider::Service::Upstart
  action :nothing
end
