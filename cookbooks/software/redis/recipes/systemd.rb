log 'Ensuring Redis job is running...'
service "redis" do
  action [ :enable, :start ]
end
