define phabricator::phabricator(
    $path="/opt/phabricator",
    $host="phabricator.local") {

    file { '/etc/apache2/sites-available/phabricator':
        content => template('phabricator/apacheconf.erb'),
        notify => Service['apache2'],
    }

    file { '/etc/apache2/sites-enabled/phabricator':
        require => File['/etc/apache2/sites-available/phabricator'],
        ensure => symlink,
        target => '/etc/apache2/sites-available/phabricator',
        notify => Service['apache2'],
    }

    file { '/var/repo':
        ensure => 'directory',
        owner => 'www-data',
        group => 'www-data',
    }


    file { '/opt/sshd_phabricator': ensure => 'directory' }
    file { '/opt/sshd_phabricator/sshd_config.phabricator':
        content => template('phabricator/sshd_config.phabricator.erb'),
    }
    file { '/opt/sshd_phabricator/phabricator-ssh-hook.sh':
        content => template('phabricator/phabricator-ssh-hook.sh.erb'),
    }

    # Install database
    exec { "$path/bin/storage upgrade --force": }
    # Base URI
    exec { "$path/bin/config set phabricator.base-uri 'http://$host/'": }
    exec { "$path/bin/config set phd.user 'phd'": }
    exec { "$path/bin/config set diffusion.ssh-user 'git'": }
    # Daemons
    exec { "$path/bin/phd start": }
}




# echo "git ALL=(phd) SETENV: NOPASSWD: /usr/bin/git-upload-pack, /usr/bin/git-receive-pack" > /etc/sudoers
# LINE ABOVE SHOULD USE visudo, no idea how to automate that.
#
#
#