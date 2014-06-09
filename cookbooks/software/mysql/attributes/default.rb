default[:mysql][:user]        = 'mysql'
default[:mysql][:config_path] = Pathname.new '/etc/mysql'
default[:mysql][:data_path]   = Pathname.new node[:central][:data] + '/mysql'