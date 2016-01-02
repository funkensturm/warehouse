execute "add-apt-repository ppa:brightbox/ruby-ng" do
  user "root"
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
    to "/usr/bin/#{file}2.2"
    action :create
  end
end

log 'Linking config.h'

link '/usr/include/ruby-2.2.0/ruby/config.h' do
  to '/usr/include/x86_64-linux-gnu/ruby-2.2.0/ruby/config.h'
  action :create
end
