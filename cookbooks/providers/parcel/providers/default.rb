action :delegate_to_package do

  name = new_resource.name
  myversion = node[:parcel][:versions][name]

  if myversion
    log "Installing unified version #{myversion} of package #{name}..."
    package name do
      version myversion
    end
  else
    log "Warning! Installing unspecified cutting-edge version of apt package #{name}..."
    package name
  end

end
