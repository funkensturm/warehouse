parcel 'tzdata'

template '/etc/timezone' do
  source 'timezone.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end

bash 'dpkg-reconfigure tzdata' do
  user 'root'
  code '/usr/sbin/dpkg-reconfigure -f noninteractive tzdata'
end
