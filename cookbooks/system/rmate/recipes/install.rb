log 'Installing rmate...'

remote_file "/usr/local/bin/mate" do
  source 'https://raw.github.com/textmate/rmate/master/bin/rmate'
  mode 0755
end
