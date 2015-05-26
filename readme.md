# Vagrash

**Vagra**&#x200B;nt Ba**sh** Scripts

## Dependencies

* Vagrant `1.5.0`+
    * Use `vagrant -v` to check your version
* Vitualbox or VMWare Fusion
* Laravel project repo

## Instructions

**First**, Copy the Vagrantfile from this repo.

```bash
$ curl -L http://bit.ly/vagrash > Vagrantfile
# or
$ wget -O Vagrantfile http://bit.ly/vagrash
```

> The `bit.ly` link will always point to the master branch version of the Vagrantfile.

**Second**, edit the `Vagrantfile` and uncomment which scripts you'd like to run. You can uncomment them by removing the `#` character before the `config.vm.provision` line.

> You can indeed have [multiple provisioning](http://docs.vagrantup.com/v2/provisioning/basic_usage.html) scripts when provisioning Vagrant.

**Third** and finally, run:

```bash
$ vagrant up
```

## What You Can Install
* Ubuntu LTS releases, currently 14.04.*
* Base Items (Git and more!)
* PHP (php-fpm)
* Composer
* Apache
* Mailcatcher
* MySQL
* PostgreSQL
* Beanstalkd
* Supervisord
