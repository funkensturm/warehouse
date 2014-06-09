parcel 'ruby2.0'
parcel 'ruby2.0-dev'

log 'Removing ruby1.9 symlinks and linking ruby2.0 bins'

%w{ ruby gem irb rdoc erb }.each do |file|
  link "/usr/bin/#{file}" do
    action :delete
  end
  
  link "/usr/bin/#{file}" do
    to "/usr/bin/#{file}2.0"
    action :create
  end
end