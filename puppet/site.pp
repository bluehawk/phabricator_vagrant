exec { "apt-get update":
    path => ["/bin", "/usr/bin", "/usr/sbin", ""]
}

package { ["php5", "mysql-server", "apache2-mpm-prefork", "php5-mysql", "php5-cli", "php5-curl", "php5-ldap", "php5-gd", "php-apc", "git", "libapache2-mod-php5" ]:
    ensure => "installed",
    require => Exec['apt-get update']
}

service { 'mysql':
    ensure => "running",
    require => Package['mysql-server'],
}

apache::loadmodule{'rewrite':
    require => Package['apache2-mpm-prefork'],
    before => Service['apache2'],
}

service { 'apache2':
    ensure => "running",
    require => Package['apache2-mpm-prefork'],
}

file { "/opt":
    ensure => directory,
}

exec { "repos":
    require => [Package["git"], File['/opt']],
    command => 'git clone git://github.com/facebook/phabricator && git clone git://github.com/facebook/libphutil && git clone git://github.com/facebook/arcanist',
    creates => '/opt/phabricator',
    path => ["/bin", "/usr/bin"],
    cwd => "/opt",
}


phabricator::phabricator { 'local':
    require => [Exec['repos'],Package['php5-cli', 'mysql-server']],
}


# http://snowulf.com/2012/04/05/puppet-quick-tip-enabling-an-apache-module/
define apache::loadmodule() {
    exec { "/usr/sbin/a2enmod $name":
        unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
        notify => Service["apache2"],
    }
}