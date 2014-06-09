## Warehouse

Cookbooks to manage a handful of servers.

#### Assumptions

* You have SSH access with sudo powers to a remote server
* That remote server runs Ubuntu 14 Server

#### Getting started...

1. Clone the repository
2. Run `bundle install` on your local machine

### Usage

First of all we need to make sure that there is some sort of chef installed on the remote server.
You can do that with the prepare command:

```bash
# Syntax
bundle exec knife solo prepare USERNAME@ENDPOINT [KNIFE OPTIONS]

# Examples
bundle exec knife solo prepare ubuntu@203.0.113.19
bundle exec knife solo prepare ubuntu@203.0.113.19 --identity-file ~/.ssh/my_ssh_key
```

This will also create a file in the local [nodes](https://github.com/funkensturm/warehouse/tree/master/nodes)
directory. Modify it according to the example json file provided there.

Run chef on the server for the first time:

```bash
# Syntax
bundle exec knife solo cook USER@ENDPOINT [KNIFE OPTIONS]

# Examples
bundle exec knife solo cook ubuntu@203.0.113.19
bundle exec knife solo cook ubuntu@203.0.113.19 --identity-file ~/.ssh/my_ssh_key --ssh-port 12345
```

For initial bootstraping you will use the ubuntu user.
During the first chef run, a new user called `chef` will be created and given passwordless sudo powers.
Once that `chef` user has been created, you should only use that one for running warehouse.
Note that SSH on the server will not listen on port 22 anymore, but on port 33071 by default (you can change the port in the local `nodes/*.json` file).

```bash
# Examples
bundle exec knife solo cook chef@203.0.113.19 --ssh-port 33071
bundle exec knife solo cook chef@203.0.113.19 --ssh-port 33071 --identity-file ~/.ssh/my_ssh_key
```

### Copyright

MIT 2014 funkensturm. See [MIT-LICENSE](http://github.com/funkensturm/warehouse/blob/master/MIT-LICENSE).
