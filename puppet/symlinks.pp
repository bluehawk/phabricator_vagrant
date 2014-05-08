 # Fix symlinks in case your host is windows (THIS WILL FAIL BADLY IF YOU ARE USING SHARED FOLDERS)
file {"$path/bin/accountadmin": ensure=>symlink, target=>'../scripts/user/account_admin.php'}
file {"$path/bin/aphlict": ensure=>symlink, target=>'../support/aphlict/server/aphlict_launcher.php'}
file {"$path/bin/audit": ensure=>symlink, target=>'../scripts/setup/manage_audit.php'}
file {"$path/bin/auth": ensure=>symlink, target=>'../scripts/setup/manage_auth.php'}
file {"$path/bin/cache": ensure=>symlink, target=>'../scripts/cache/manage_cache.php'}
file {"$path/bin/celerity": ensure=>symlink, target=>'../scripts/setup/manage_celerity.php'}
file {"$path/bin/commit-hook": ensure=>symlink, target=>'../scripts/repository/commit_hook.php'}
file {"$path/bin/config": ensure=>symlink, target=>'../scripts/setup/manage_config.php'}
file {"$path/bin/diviner": ensure=>symlink, target=>'../scripts/diviner/diviner.php'}
file {"$path/bin/drydock": ensure=>symlink, target=>'../scripts/drydock/drydock_control.php'}
file {"$path/bin/fact": ensure=>symlink, target=>'../scripts/fact/manage_facts.php'}
file {"$path/bin/feed": ensure=>symlink, target=>'../scripts/setup/manage_feed.php'}
file {"$path/bin/files": ensure=>symlink, target=>'../scripts/files/manage_files.php'}
file {"$path/bin/harbormaster": ensure=>symlink, target=>'../scripts/setup/manage_harbormaster.php'}
file {"$path/bin/i18n": ensure=>symlink, target=>'../scripts/setup/manage_i18n.php'}
file {"$path/bin/lipsum": ensure=>symlink, target=>'../scripts/lipsum/manage_lipsum.php'}
file {"$path/bin/mail": ensure=>symlink, target=>'../scripts/mail/manage_mail.php'}
file {"$path/bin/phd": ensure=>symlink, target=>'../scripts/daemon/manage_daemons.php'}
file {"$path/bin/policy": ensure=>symlink, target=>'../scripts/setup/manage_policy.php'}
file {"$path/bin/repository": ensure=>symlink, target=>'../scripts/repository/manage_repositories.php'}
file {"$path/bin/search": ensure=>symlink, target=>'../scripts/search/manage_search.php'}
file {"$path/bin/ssh-auth": ensure=>symlink, target=>'../scripts/ssh/ssh-auth.php'}
file {"$path/bin/ssh-auth-key": ensure=>symlink, target=>'../scripts/ssh/ssh-auth-key.php'}
file {"$path/bin/ssh-connect": ensure=>symlink, target=>'../scripts/ssh/ssh-connect.php'}
file {"$path/bin/ssh-exec": ensure=>symlink, target=>'../scripts/ssh/ssh-exec.php'}
file {"$path/bin/storage": ensure=>symlink, target=>'../scripts/sql/manage_storage.php'}
file {"$path/scripts/daemon/phd-daemon" : ensure=>symlink, target=>'launch_daemon.php'}