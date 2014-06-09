password = node[:mysql][:password]

if password.to_s == ""
  raise "You need to set a MySQL password!"
end

include_recipe 'mysql::preseed'
include_recipe 'mysql::install'
include_recipe 'mysql::config'
include_recipe 'mysql::upstart'