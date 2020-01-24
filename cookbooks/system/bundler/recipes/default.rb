log 'Installing system-wide Bundler...'

bash 'install-bundler' do
  code 'gem install bundler'
end
