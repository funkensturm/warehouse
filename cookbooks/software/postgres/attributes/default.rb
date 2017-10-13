default[:postgres][:user]        = 'postgres'
default[:postgres][:version]     = '9.3'
default[:postgres][:config_path] = Pathname.new "/etc/postgresql/#{node[:postgres][:version]}/main"
