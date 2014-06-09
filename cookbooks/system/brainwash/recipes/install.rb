log 'Installing brainwash...'
remote_file '/usr/local/bin/brainwash' do
  source 'https://gist.githubusercontent.com/halo/9159206/raw/brainwash'
  mode '0755'
end
