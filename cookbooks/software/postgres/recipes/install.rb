log "Installing PostgreSQL server..."
parcel 'postgresql'
parcel 'postgresql-contrib'
parcel 'libpq-dev'

log "Creating PostgreSQL root user..."
execute "ppa" do
  command "postgres -l -c 'createuser --superuser root'"
end