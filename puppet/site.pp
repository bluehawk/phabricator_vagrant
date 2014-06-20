# This manifiest requests two factor variables:
# path - the path to the Phabricator install
# host - the hostname of the machine

exec { "apt-get update":
    path => ["/bin", "/usr/bin", "/usr/sbin"]
}

package { ["git", "mysql-server", "apache2-mpm-prefork", "php5", "libapache2-mod-php5",
           "php5-mysql", "php5-cli", "php5-curl", "php5-ldap", "php5-gd", "php-apc", "php5-xdebug" ]:
    ensure => "installed",
    require => Exec['apt-get update']
}

# MySQL
service { 'mysql':
    ensure => "running",
    require => Package['mysql-server'],
}
# Fix bind-address so we can access mysql remotely
exec { 'mysql bind-address':
    command => 'sed "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf -i',
    path => ["/bin", "/usr/bin", "/usr/sbin"],
    notify => Service['mysql'],
    require => Package['mysql-server'],
}
# Fix mysql permissions so we have privileges remotely
exec { 'mysql remote privileges':
    command => 'mysql -u root -h 127.0.0.1 -e \'USE mysql; UPDATE user SET host="%" WHERE host="127.0.0.1"; FLUSH PRIVILEGES;\'',
    path => ["/bin", "/usr/bin", "/usr/sbin"],
    notify => Service['mysql'],
    require => Package['mysql-server'],
}

# Apache
apache::loadmodule{'rewrite':
    require => Package['apache2-mpm-prefork'],
    before => Service['apache2'],
}
service { 'apache2':
    ensure => "running",
    require => Package['apache2-mpm-prefork'],
}
# XDEBUG
#file

# Without this SSHD returns "Unsafe AuthorizedKeysCommand: bad ownership or modes for directory /opt"
file { '/opt':
    owner => 'root',
    group => 'root'
}

# Set up phabricator locally
phabricator::phabricator { 'local':
    require => [Package['php5-cli', 'mysql-server']],
    host => $host,
    path => $path
}

# Setup the SSH hosting of repositories
phabricator::sshd { 'phab_sshd':
    require => Phabricator::Phabricator['local'],
    path => $path
}





# http://snowulf.com/2012/04/05/puppet-quick-tip-enabling-an-apache-module/
define apache::loadmodule() {
    exec { "/usr/sbin/a2enmod $name":
        unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
        notify => Service["apache2"],
    }
}