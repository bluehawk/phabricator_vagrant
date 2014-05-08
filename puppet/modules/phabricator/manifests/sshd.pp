define phabricator::sshd(
    $path) {

    user { 'git':
        ensure => "present",
    }

    exec { "$path/bin/config set diffusion.ssh-user 'git'": }

    file { '/opt/sshd_phabricator': ensure => 'directory' }
    file { '/opt/sshd_phabricator/sshd_config.phabricator':
        content => template('phabricator/sshd_config.phabricator.erb'),
    }
    file { '/opt/sshd_phabricator/phabricator-ssh-hook.sh':
        content => template('phabricator/phabricator-ssh-hook.sh.erb'),
    }

    # file { '/etc/sudoers.d/phabricator':
    #     content => "git ALL=(phd) SETENV: NOPASSWD: /usr/bin/git-upload-pack, /usr/bin/git-receive-pack",
    # }

    package { 'openssh-server':
        ensure => 'installed'
    }



}