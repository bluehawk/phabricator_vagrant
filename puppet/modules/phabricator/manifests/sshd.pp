define phabricator::sshd(
    $path) {

    user { 'git':
        ensure => "present",
        shell => "/bin/bash",
        password => ''
    }

    exec { "$path/bin/config set diffusion.ssh-user 'git'": }

    file { '/opt/sshd_phabricator': ensure => 'directory' }
    file { '/opt/sshd_phabricator/sshd_config.phabricator':
        content => template('phabricator/sshd_config.phabricator.erb'),
    }
    file { '/opt/sshd_phabricator/phabricator-ssh-hook.sh':
        content => template('phabricator/phabricator-ssh-hook.sh.erb'),
        mode => '+x'
    }

    file { '/etc/sudoers.d/phabricator':
        # For reasons that are beyord my understanding, the newline at the end is incredibly important, and sudo breaks without it.
        content => "git ALL=(phd) SETENV: NOPASSWD: /usr/bin/git-upload-pack, /usr/bin/git-receive-pack\n",
        mode => '440',
    }

    package { 'openssh-server':
        ensure => 'installed'
    }

    service { 'phabricator sshd':
        binary => "/usr/sbin/sshd -f /opt/sshd_phabricator/sshd_config.phabricator",
        ensure => "running",
        provider => "base",
    }
}