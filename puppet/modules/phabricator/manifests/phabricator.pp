define phabricator::phabricator(
    $path,
    $host) {

    file { '/etc/apache2/sites-available/phabricator.conf':
        content => template('phabricator/apacheconf.erb'),
        notify => Service['apache2'],
    }

    file { '/etc/apache2/sites-enabled/phabricator.conf':
        require => File['/etc/apache2/sites-available/phabricator.conf'],
        ensure => symlink,
        target => '/etc/apache2/sites-available/phabricator.conf',
        notify => Service['apache2'],
    }

    file { '/var/repo':
        ensure => 'directory',
        owner => 'www-data',
        group => 'www-data',
    }


    user { 'phd':
        ensure => "present",
    }

    # Install database
    exec { "$path/bin/storage upgrade --force": }
    # Base URI
    exec { "$path/bin/config set phabricator.base-uri 'http://$host/'": }
    # Daemons
    file { '/var/run/phd': ensure=>'directory', owner=>'phd', group=>'phd', before=>Exec["$path/bin/phd restart"]}
    file { '/var/log/phd': ensure=>'directory', owner=>'phd', group=>'phd', before=>Exec["$path/bin/phd restart"]}
    file { "$path/scripts/daemon/phd-daemon": ensure=>'symlink', target=>"launch_daemon.php", before=>Exec["$path/bin/phd restart"]}
    exec { "$path/bin/config set phd.user 'phd' && $path/bin/config set phd.pid-directory '/var/run/phd' && $path/bin/config set phd.log-directory '/var/log/phd'": before=>Exec["$path/bin/phd restart"]}
    exec { "$path/bin/phd restart": }
}

