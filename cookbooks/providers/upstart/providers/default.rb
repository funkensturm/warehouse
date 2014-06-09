action :setup do

  log 'Ensuring upstart jobs directory...'
  directory '/etc/init' do
    owner 'root'
    group 'root'
    mode '0755'
  end

  log "Ensuring permissions for the log file of upstart job #{new_resource.name}..."
  file new_resource.logfile do
    owner new_resource.user
    group new_resource.user
    mode '0644'
    action :touch
  end

  log "Creating upstart job #{new_resource.name}..."

  if new_resource.bash_profile && !new_resource.envs['HOME'] && !new_resource.envs[:HOME]
    raise 'When you use "bash_profile true" you also need to provide HOME as an environment variable'
  end

  template "/etc/init/#{new_resource.name}.conf" do
    cookbook 'upstart'
    source 'upstart.conf.erb'
    variables({
      autostart:           new_resource.autostart,
      command:             new_resource.command,
      envs:                new_resource.envs,
      expect:              new_resource.expect,
      kill_signal:         new_resource.kill_signal,
      kill_timeout:        new_resource.kill_timeout,
      logfile:             new_resource.logfile,
      name:                new_resource.name,
      nice:                new_resource.nice,
      post_stop:           new_resource.post_stop,
      pre_start:           new_resource.pre_start,
      pre_stop:            new_resource.pre_stop,
      respawn:             new_resource.respawn,
      start_on:            new_resource.start_on,
      stop_on:             new_resource.stop_on,
      user:                new_resource.user,
      load_envs_from_file: new_resource.load_envs_from_file,
      working_dir:         new_resource.working_dir,
      bash_profile:        new_resource.bash_profile,
      high_nofile_limit:   new_resource.high_nofile_limit,
      memlock_unlimited:   new_resource.memlock_unlimited,
    })
  end

end
