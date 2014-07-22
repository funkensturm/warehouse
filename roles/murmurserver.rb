name 'murmurserver'
description 'Runs the murmur server for the mumble client'

run_list(
  'role[root]',
  'recipe[murmur]'
)
