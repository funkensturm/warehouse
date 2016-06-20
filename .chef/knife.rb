chef_repo_path        = Pathname.new File.expand_path('..', File.dirname(__FILE__))
cookbooks_containers  = chef_repo_path.join 'cookbooks/*'
custom_cookbooks_path = chef_repo_path.join '../warehouse_apps'
all_cookbook_paths    = Dir.glob(cookbooks_containers.to_s).select { |entry| File.directory?(entry) }

if custom_cookbooks_path.directory?
  all_cookbook_paths << custom_cookbooks_path
else
  puts
  puts "  No custom cookbooks found at #{custom_cookbooks_path}"
  puts
end

cookbook_path    all_cookbook_paths.map(&:to_s)
node_path        'nodes'
role_path        'roles'
environment_path 'environments'
data_bag_path    '/dev/null'
ssl_verify_mode  :verify_peer
