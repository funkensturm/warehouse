This cookbook configures bash and SSH for a user.

It also provides the following resources:

* access_user
* access\_bash_profile
* access\_ssh_config

`access_user` creates a user and configures bash and SSH.
If you would like to just configure bash, use `access_bash_profile`
and if you would like to configure just SSH, use `access_ssh_config`.

Usage:

    access_user USERNAME do
      home HOME_PATH
      group USERGROUP
    end

    access_bash_profile HOME_PATH do
      name USERNAME
      group USERGROUP
    end

    access_ssh_config HOME_PATH do
      name USERNAME
      group USERGROUP
    end

Examples:

    access_user 'bob' do
      home '/home/bob'
      group 'deploy'
    end

    access_bash_profile '/home/john' do
      name 'john'
      group 'dudes'
    end

    access_ssh_config '/home/superman' do
      name 'superman'
      group 'admins'
    end
