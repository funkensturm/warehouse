chef_repo_path        = Pathname.new File.expand_path('..', File.dirname(__FILE__))
cookbooks_containers  = chef_repo_path.join 'cookbooks/*'
all_cookbook_paths    = Dir.glob(cookbooks_containers.to_s).select { |entry| File.directory?(entry) }

custom_cookbooks_paths = []
custom_cookbooks_paths << chef_repo_path.join('../apps')
custom_cookbooks_paths << Pathname.new(File.dirname(ARGV.last)).join('cookbooks')

puts
custom_cookbooks_paths.compact.each do |path|
  if path.directory?
    puts "  Using custom cookbooks located at #{path}"
    all_cookbook_paths << path
  else
    puts "  No custom cookbooks found at #{path}"
  end
end
puts

cookbook_path    all_cookbook_paths.map(&:to_s)
node_path        'nodes'
role_path        'roles'
environment_path 'environments'
data_bag_path    '/dev/null'
ssl_verify_mode  :verify_peer
