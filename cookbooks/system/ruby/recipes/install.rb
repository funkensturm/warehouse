version      = node[:ruby][:version]

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


parcel "ruby#{version}"
parcel "ruby#{version}-dev"
# sudo update-alternatives --config ruby
# sudo update-alternatives --config gem

log "Removing ruby1.9 symlinks and linking #{version} bins"

%w{ ruby gem irb rdoc erb }.each do |file|
  link "/usr/bin/#{file}" do
    action :delete
  end

  link "/usr/bin/#{file}" do
    to "/usr/bin/#{file}#{version}"
    action :create
  end
end

log 'Linking config.h'

link "/usr/include/ruby-#{version}.0/ruby/config.h" do
  to "/usr/include/x86_64-linux-gnu/ruby-#{version}.0/ruby/config.h"
  action :create
end
