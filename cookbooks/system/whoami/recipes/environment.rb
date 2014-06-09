allowed_environments = %w{ production staging development test }

unless allowed_environments.include? node.chef_environment
  raise "Dude, your environment #{node.chef_environment.inspect} is really not one of #{allowed_environments.join(', ')}."
end
