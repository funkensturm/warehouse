name 'webserver'
description 'Ready to deploy Ruby web apps.'

run_list(
  'role[root]',
  'recipe[passenger]'
)
