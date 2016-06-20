apt_repository 'ruby' do
  uri          'http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu'
  distribution node['lsb']['codename']
  components   ['main']
  keyserver    'keyserver.ubuntu.com'
  key          'C3173AA6'
  deb_src      true
end

execute "apt-get update" do
  user "root"
end

parcel 'ruby2.2'
parcel 'ruby2.2-dev'

log 'Removing ruby1.9 symlinks and linking ruby2.2 bins'

%w{ ruby gem irb rdoc erb }.each do |file|
  link "/usr/bin/#{file}" do
    action :delete
  end

  link "/usr/bin/#{file}" do
    to "/etc/alternatives/#{file}"
    action :create
  end
end

log 'Linking config.h'

link '/usr/include/ruby-2.2.0/ruby/config.h' do
  to '/usr/include/x86_64-linux-gnu/ruby-2.2.0/ruby/config.h'
  action :create
end
