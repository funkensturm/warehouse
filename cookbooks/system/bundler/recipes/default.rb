log 'Installing system-wide Bundler...'

bash 'install-bundler' do
  code 'gem install bundler --no-rdoc --no-ri'
end
