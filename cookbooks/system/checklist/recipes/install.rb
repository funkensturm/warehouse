log 'Installing checklist...'
cookbook_file '/usr/local/bin/checklist' do
  source 'checklist'
  mode '0755'
end
