# This is the user we use for running chef. It never changes.

default[:whoami][:home]  = '/home/chef'
default[:whoami][:user]  = 'chef'
default[:whoami][:group] = 'chef'

# The rest is about the server itself.
# Overwrite this in nodes/[...].json
default[:whoami][:identifier]  = 'rookie'
