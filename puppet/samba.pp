package{ "samba": }

service { "smbd":
  require => Package['samba'],
}


$samba_conf = "[global]
       workgroup = WORKGROUP
       netbios name = PHAB_LOCAL_SAMBA
       server string = Samba Server %v
       map to guest = Bad User
       log file = /var/log/samba/log.%m
       max log size = 2000
       socket options = TCP_NODELAY SO_RCVBUF=8192 SO_SNDBUF=8192
       preferred master = No
       local master = No
       dns proxy = No
       security = User

# Share
[opt]
       path = /opt
       valid users = root
       read only = No
       create mask = 0644
       directory mask = 0755
"

file{"/etc/samba/smb.conf":
    content => "$samba_conf",
    require => Package['samba'],
    notify => Service['smbd'],
}

$samba_password = "supersecretpassword"

exec{ "set samba password":
    #command => 'echo -ne "$samba_password\n$samba_password\n" | smbpasswd -a root',
    command => 'bash -c "(echo supersecretpassword; echo supersecretpassword ) | smbpasswd -a root"',
    path => ['/bin', '/usr/bin'],
    require => Package['samba'],
}