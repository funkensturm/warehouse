nginx_path = node[:passenger][:nginx_path]
conf_path  = node[:passenger][:config_path]
html_path  = Pathname.new '/usr/share/nginx/html'

log 'Removing unnecessary, confusing directories...'

%w{ sites-available sites-enabled conf.d }.each do |path|
  directory nginx_path.join(path).to_s do
    action :delete
    recursive true
  end
end

log 'Ensuring configuraiton directories...'

[conf_path, html_path].each do |path|
  directory path.to_s do
    recursive true
    mode '0755'
  end
end

cookbook_file nginx_path.join('mime.types').to_s do
  source 'mime.types'
  mode '0644'
end

log 'Ensuring default fallback HTML pages...'

%w{ 40x.html 50x.html index.html }.each do |file|
  cookbook_file html_path.join(file).to_s do
    source file
    mode '0644'
  end
end






