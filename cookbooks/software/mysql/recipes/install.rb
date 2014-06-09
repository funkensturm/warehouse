log "Installing MySQL server..."
parcel 'mysql-server'


# grants_path = "#{node[:mysql][:config_path]}/mysql_grants.sql"
# 
# begin
#   t = resources("template[#{grants_path}]")
# rescue
#   Chef::Log.info("Could not find previously defined grants.sql resource")
#   t = template grants_path do
#     source "grants.sql.erb"
#     owner "root"
#     group "root"
#     mode "0600"
#     action :create
#   end
# end
# 
# execute "mysql-install-privileges" do
#   command "/usr/bin/mysql -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }#{node['mysql']['server_root_password']} < #{grants_path}"
#   action :nothing
#   subscribes :run, resources("template[#{grants_path}]"), :immediately
# end

# include_recipe 'mysql::privileges'