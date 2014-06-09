# See https://help.ubuntu.com/community/UFW
# and http://man.he.net/man8/ufw

# Deny everything by default
ufw = ['default deny']

# Allow for SSH for everyone on custom and default port (to not shut us out)
sshd_port = node[:sshd][:port]
ufw << "allow 22/tcp"
ufw << "allow #{sshd_port}/tcp"

# Allow web traffic
if node.run_list.roles.include?('webserver')
  ufw << "allow 80/tcp"    # HTTP
  ufw << "allow 443/tcp"   # HTTPS
end

log %{Resetting firewall...}
bash "reset-firewall" do
  code "ufw --force reset"
end

log %{Setting firewall permissions...}
bash "configure-ufw" do
  code ufw.map { |rule| "ufw #{rule}"  }.join(' && ')
end

log %{Enabling firewall...}
bash "enable-firewall" do
  code "ufw --force enable"
end
