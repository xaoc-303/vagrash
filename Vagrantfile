# -*- mode: ruby -*-
# vi: set ft=ruby :

# Config Github Settings
github_username = "xaoc-303"
github_repo     = "vagrash"
github_branch   = "master"
github_url      = "https://raw.githubusercontent.com/#{github_username}/#{github_repo}/#{github_branch}"

hostname        = "vagrash.dev"
vbox_hostname   = "vagrash"

# server_ip             = "10.0.2.15"
server_memory         = "1024" # MB

mysql_root_password   = "pass"
mysql_database_name   = "vagrash"

postgresql_root_password   = "pass"
postgresql_database_name   = "vagrash"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define vbox_hostname do |vm1config|
    vm1config.vm.box = vbox_hostname
  end
  config.vm.hostname = "homestead"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8000" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8000
  config.vm.network "forwarded_port", guest: 3306, host: 33060
  config.vm.network "forwarded_port", guest: 5432, host: 54320
  config.vm.network "forwarded_port", guest: 1080, host: 10800


  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: server_ip

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network", bridge: 'en0: Wi-Fi (AirPort)'

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./", "/var/www/#{hostname}", create:true, :mount_options => ["dmode=777","fmode=666"]

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "virtualbox" do |vb|
    vb.name = vbox_hostname
    # vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", server_memory]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provision :shell, path: "#{github_url}/scripts/setup-before.sh"
  config.vm.provision :shell, path: "#{github_url}/scripts/locale.sh"
  config.vm.provision :shell, path: "#{github_url}/scripts/time-sync.sh"
  config.vm.provision :shell, path: "#{github_url}/scripts/php.sh"
  config.vm.provision :shell, path: "#{github_url}/scripts/mysql.sh", args: [mysql_root_password, mysql_database_name]
  # config.vm.provision :shell, path: "#{github_url}/scripts/postgresql.sh", args: [postgresql_root_password, postgresql_database_name]
  config.vm.provision :shell, path: "#{github_url}/scripts/apache.sh", args: [hostname]
  config.vm.provision :shell, path: "#{github_url}/scripts/apache-vhost.sh", args: [hostname, hostname]
  # config.vm.provision :shell, path: "#{github_url}/scripts/apache-vhost.sh", args: [hostname, "admin.#{hostname}"]
  # config.vm.provision :shell, path: "#{github_url}/scripts/apache-vhost.sh", args: [hostname, "api.#{hostname}"]
  # config.vm.provision :shell, path: "#{github_url}/scripts/mailcatcher.sh"
  # config.vm.provision :shell, path: "#{github_url}/scripts/queue-install.sh"
  # config.vm.provision :shell, path: "#{github_url}/scripts/queue-add.sh", args: ['default']
  config.vm.provision :shell, path: "#{github_url}/scripts/setup-after.sh", args: [hostname]
  config.vm.provision :shell, path: "#{github_url}/scripts/laravel.sh", args: [hostname, '4.2.*']
  config.vm.provision :shell, path: "#{github_url}/scripts/setup-local-download.sh", args: [hostname, github_url]
  # config.vm.provision :shell, :path => "setup-local.sh", args: [hostname]

  # Enable provisioning with CFEngine. CFEngine Community packages are
  # automatically installed. For example, configure the host as a
  # policy server and optionally a policy file to run:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.am_policy_hub = true
  #   # cf.run_file = "motd.cf"
  # end
  #
  # You can also configure and bootstrap a client to an existing
  # policy server:
  #
  # config.vm.provision "cfengine" do |cf|
  #   cf.policy_server_address = "10.0.2.15"
  # end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { mysql_password: "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end