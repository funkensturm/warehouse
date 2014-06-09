name 'root'
description 'The root of it all.'

run_list(
  'recipe[whoami]',
  'recipe[central]',
  'recipe[apt]',
  'recipe[build-essential]',
  'recipe[ntp]',
  'recipe[timezone]',
  'recipe[updatedb]',
  'recipe[ruby]',
  'recipe[bundler]',
  'recipe[rmate]',
  'recipe[brainwash]',
  'recipe[sshd]',
  'recipe[ufw]'
)
